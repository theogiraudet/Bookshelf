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

scoreboard players set $math.ipow.x bs.in 12
scoreboard players set $math.ipow.y bs.in 7
function #bs.math:ipow
assert score $math.ipow bs.out matches 35831808

scoreboard players set $math.ipow.x bs.in 42
scoreboard players set $math.ipow.y bs.in 3
function #bs.math:ipow
assert score $math.ipow bs.out matches 74088
