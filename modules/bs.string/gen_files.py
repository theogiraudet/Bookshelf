from beet import Context, Function
import string

from bookshelf.helpers import render_snbt

LOWER_TO_UPPER = {chr(c): chr(c).upper() for c in range(0x110000) if chr(c).islower()}
UPPER_TO_LOWER = {chr(c): chr(c).lower() for c in range(0x110000) if chr(c).isupper()}
INDEX_TO_CHAR = {i: chr(c) for i, c in enumerate(range(0x110000)) if  not (0xD800 <= c <= 0xDFFF) and chr(c).isprintable()}
CHAR_TO_INDEX = {chr(c): i for i, c in enumerate(range(0x110000)) if not (0xD800 <= c <= 0xDFFF) and chr(c).isprintable()}

def beet_default(ctx: Context) -> None:
    """Generate files used by the bs.string module."""
    with ctx.override(generate_namespace=ctx.directory.name):
        ctx.generate("import/char_table",
            upper=render_snbt(LOWER_TO_UPPER),
            lower=render_snbt(UPPER_TO_LOWER),
            char_to_index=render_snbt(CHAR_TO_INDEX),
            index_to_char=render_snbt(INDEX_TO_CHAR),
            render=Function(source_path="char_table.jinja", encoding="utf-16"),
        )

        for size in {*range(1, 65), 128, 256}:
            ctx.generate(f"concat/join/{size}",
                size=size,
                render=Function(source_path="concat/join.jinja"),
            )
            ctx.generate(f"concat/pair/{size}",
                size=size,
                max=256,
                render=Function(source_path="concat/pair.jinja"),
            )
