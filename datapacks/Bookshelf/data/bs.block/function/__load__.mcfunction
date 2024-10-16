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
#
# Documentation of the feature: https://bookshelf.docs.gunivers.net/en/latest/modules/block.html
# ------------------------------------------------------------------------------------------------------------

forceload add -30000000 1600
setblock -30000000 0 1606 minecraft:decorated_pot

scoreboard objectives add bs.data dummy [{"text":"BS ","color":"dark_gray"},{"text":"Data","color":"aqua"}]

function bs.block:load/blocks_table
function bs.block:load/block_states
function bs.block:load/items_hashmap
function bs.block:load/types_hashmap
function bs.block:load/mapping_registry

data modify storage bs:out block set value {}
