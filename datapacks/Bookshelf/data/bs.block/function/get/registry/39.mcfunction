# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2024 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/Gunivers/Bookshelf).
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

# This file was automatically generated, do not edit it
execute if block ~ ~ ~ #bs.block:has_state[facing=north] run data modify storage bs:out block._[{n:"facing"}].o[{v:"north"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[facing=south] run data modify storage bs:out block._[{n:"facing"}].o[{v:"south"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[facing=west] run data modify storage bs:out block._[{n:"facing"}].o[{v:"west"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[facing=east] run data modify storage bs:out block._[{n:"facing"}].o[{v:"east"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[power=0] run data modify storage bs:out block._[{n:"power"}].o[{v:"0"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[power=1] run data modify storage bs:out block._[{n:"power"}].o[{v:"1"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[power=2] run data modify storage bs:out block._[{n:"power"}].o[{v:"2"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[power=3] run data modify storage bs:out block._[{n:"power"}].o[{v:"3"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[power=4] run data modify storage bs:out block._[{n:"power"}].o[{v:"4"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[power=5] run data modify storage bs:out block._[{n:"power"}].o[{v:"5"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[power=6] run data modify storage bs:out block._[{n:"power"}].o[{v:"6"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[power=7] run data modify storage bs:out block._[{n:"power"}].o[{v:"7"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[power=8] run data modify storage bs:out block._[{n:"power"}].o[{v:"8"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[power=9] run data modify storage bs:out block._[{n:"power"}].o[{v:"9"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[power=10] run data modify storage bs:out block._[{n:"power"}].o[{v:"10"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[power=11] run data modify storage bs:out block._[{n:"power"}].o[{v:"11"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[power=12] run data modify storage bs:out block._[{n:"power"}].o[{v:"12"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[power=13] run data modify storage bs:out block._[{n:"power"}].o[{v:"13"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[power=14] run data modify storage bs:out block._[{n:"power"}].o[{v:"14"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[power=15] run data modify storage bs:out block._[{n:"power"}].o[{v:"15"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[sculk_sensor_phase=inactive] run data modify storage bs:out block._[{n:"sculk_sensor_phase"}].o[{v:"inactive"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[sculk_sensor_phase=active] run data modify storage bs:out block._[{n:"sculk_sensor_phase"}].o[{v:"active"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[sculk_sensor_phase=cooldown] run data modify storage bs:out block._[{n:"sculk_sensor_phase"}].o[{v:"cooldown"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[waterlogged=false] run data modify storage bs:out block._[{n:"waterlogged"}].o[{v:"false"}].c set value 1b
execute if block ~ ~ ~ #bs.block:has_state[waterlogged=true] run data modify storage bs:out block._[{n:"waterlogged"}].o[{v:"true"}].c set value 1b
