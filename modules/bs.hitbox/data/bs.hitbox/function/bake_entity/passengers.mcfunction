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

tag @s add bs.hitbox.baked
tag @s remove bs.hitbox.custom
tag @s remove bs.hitbox.centered

function #bs.hitbox:get_entity
execute store result score @s bs.width run data get storage bs:out hitbox.width 5000
execute store result score @s bs.height run data get storage bs:out hitbox.height 5000
execute store result score @s bs.depth run data get storage bs:out hitbox.depth 5000
execute store result score #s bs.ctx run data get storage bs:out hitbox.scale 1000
scoreboard players operation @s bs.width *= #s bs.ctx
scoreboard players operation @s bs.height *= #s bs.ctx
scoreboard players operation @s bs.depth *= #s bs.ctx

execute store result score #i bs.ctx run data get entity @s Pos[1] 10000
scoreboard players operation #i bs.ctx -= #y bs.ctx
scoreboard players operation #i bs.ctx *= 1000 bs.const
scoreboard players operation @s bs.height += #i bs.ctx

scoreboard players operation #w bs.ctx > @s bs.width
scoreboard players operation #d bs.ctx > @s bs.depth
scoreboard players operation #h bs.ctx > @s bs.height

execute on passengers run function bs.hitbox:bake_entity/passengers
