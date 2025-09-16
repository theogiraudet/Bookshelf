from __future__ import annotations

import asyncio
import logging
import shutil
from queue import Queue
from threading import Thread
from typing import TYPE_CHECKING

from httpx import AsyncClient, HTTPStatusError
from platformdirs import PlatformDirs

from . import assets, server

if TYPE_CHECKING:
    from collections.abc import AsyncIterable
    from pathlib import Path

dirs = PlatformDirs(appname="packtest", appauthor="mcbookshelf", ensure_exists=True)


async def run(datapacks: Path, mc_version: str) -> AsyncIterable[server.LogEvent]:
    """Configure then start a PackTest server for a specified Minecraft version."""
    work_dir = dirs.user_cache_path / f"v{mc_version}"
    world_dir = work_dir / "world"

    shutil.rmtree(world_dir, ignore_errors=True)
    world_dir.mkdir(parents=True, exist_ok=True)
    shutil.copytree(datapacks, world_dir / "datapacks")

    try:
        async with AsyncClient() as client:
            await assets.download(client, mc_version, work_dir)
        async for log in server.run(work_dir):
            yield log
    except assets.AssetResolutionError as e:
        yield server.LogEvent(str(e), logging.WARNING)
    except HTTPStatusError as e:
        yield server.LogEvent(str(e), logging.ERROR)


class WorkerStream[T]:
    """Synchronous iterable for streaming results from an AsyncIterable coroutine."""

    def __init__(self, coro: AsyncIterable[T]) -> None:
        """Initialize the WorkerStream with a coroutine."""
        self._queue: Queue[T | None] = Queue()
        Thread(target=self._run, args=(coro,), daemon=True).start()

    def _run(self, coro: AsyncIterable[T]) -> None:
        """Run the coroutine and populate the queue with results."""
        async def runner() -> None:
            async for item in coro:
                self._queue.put(item)
            self._queue.put(None)
        asyncio.run(runner())

    def __iter__(self) -> WorkerStream[T]:
        """Return an iterator for synchronous iteration."""
        return self

    def __next__(self) -> T:
        """Get the next item from the queue or raise StopIteration."""
        item = self._queue.get()
        if item is None:
            raise StopIteration
        return item
