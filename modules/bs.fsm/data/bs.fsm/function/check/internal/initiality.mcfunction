# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2026 Gunivers
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

# Input:
# Storage: bs:ctx _.template (a FSM)
# Macro: initial: state

# Output:
# Storage: bs:ctx _.initial (a state)
# Return 0 or 1 (0 if the state does not exist, 1 if it does)

data remove storage bs:ctx _.initial
# We save the initial property directly in the state object
$data modify storage bs:ctx _.template.states[{name: $(initial)}].initial set value true
$return run data modify storage bs:ctx _.initial set from storage bs:ctx _.template.states[{name: $(initial)}]
