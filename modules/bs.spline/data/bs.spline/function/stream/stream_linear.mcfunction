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

data modify storage bs:ctx _ set from storage bs:in spline.stream_linear
data modify storage bs:ctx _.type set value "linear"

scoreboard players set #t bs.ctx 1000
execute store result score #s bs.ctx run data get storage bs:ctx _.step 1000
scoreboard players operation #t bs.ctx -= #s bs.ctx

execute store result score #m bs.ctx if data storage bs:ctx _.points[]
execute store result score #n bs.ctx if data storage bs:ctx _.points[][2]
execute if score #n bs.ctx = #m bs.ctx run data modify storage bs:ctx _.coeffs set value [0,0,0,0]
execute if score #n bs.ctx = #m bs.ctx run return run function bs.spline:stream/stream_3d with storage bs:ctx _
execute store result score #n bs.ctx if data storage bs:ctx _.points[][1]
execute if score #n bs.ctx = #m bs.ctx run data modify storage bs:ctx _.coeffs set value [0,0,0,0,0,0,0,0]
execute if score #n bs.ctx = #m bs.ctx run return run function bs.spline:stream/stream_2d with storage bs:ctx _
execute store result score #n bs.ctx if data storage bs:ctx _.points[][0]
execute if score #n bs.ctx = #m bs.ctx run data modify storage bs:ctx _.coeffs set value [0,0,0,0,0,0,0,0,0,0,0,0]
execute if score #n bs.ctx = #m bs.ctx run return run function bs.spline:stream/stream_1d with storage bs:ctx _
