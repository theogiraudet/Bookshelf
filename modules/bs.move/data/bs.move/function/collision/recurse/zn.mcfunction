# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
# ------------------------------------------------------------------------------------------------------------

$execute if score #move.b bs.data matches 1 unless block ~ ~ ~ $(ignored_blocks) run function bs.move:collision/check/block/any with storage bs:data move
$execute if score #move.e bs.data matches 1 as @e[type=!$(ignored_entities),tag=$(entities),tag=!bs.move.omit,dx=0] run function bs.move:collision/check/entity/any

scoreboard players remove #move.z bs.data 10000000
execute if score #move.z bs.data >= #move.mz bs.data positioned ~ ~ ~-1 run function bs.move:collision/recurse/zn with storage bs:data move
