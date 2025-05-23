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

execute store result score #dump.count bs.data run data get storage bs:data dump.stack[-1].var
execute if score #dump.count bs.data matches 0 run return run function bs.dump:format/compound/empty

function bs.dump:format/brace/open with storage bs:const dump
function bs.dump:key/get
function bs.dump:interpret/compound/loop with storage bs:data dump.stack[-1]
data modify storage bs:data dump.out append value "\n"
data modify storage bs:data dump.out append from storage bs:data dump.stack[].indent
data remove storage bs:data dump.out[-1]
function bs.dump:format/brace/close with storage bs:const dump
