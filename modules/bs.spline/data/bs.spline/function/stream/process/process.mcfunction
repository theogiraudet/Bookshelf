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

data modify storage bs:ctx _ set from storage bs:data spline.process[-1]
execute store result score #t bs.ctx store result storage bs:ctx x int 1 run data get storage bs:ctx _.time 1000
execute store result score #s bs.ctx run data get storage bs:ctx _.step 1000

data modify storage bs:ctx _.seg set from storage bs:ctx _.points
$function bs.spline:utils/$(type)/lookup_coefficients with storage bs:ctx
function bs.spline:utils/compute with storage bs:ctx _
data modify storage bs:lambda spline.point set from storage bs:ctx _.out

execute store result storage bs:ctx x int 1 run scoreboard players operation #t bs.ctx += #s bs.ctx
$execute if score #t bs.ctx matches 1000.. run function bs.spline:utils/$(type)/next_segment
execute if data storage bs:ctx _.points[3] run function bs.spline:stream/process/schedule

function bs.spline:utils/callback with storage bs:ctx _
data remove storage bs:data spline.process[-1]
