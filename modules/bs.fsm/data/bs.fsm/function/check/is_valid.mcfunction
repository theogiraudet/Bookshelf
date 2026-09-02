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
# Storage: bs:ctx _.fsm (a FSM)

# Missing checks:
# - Check the structural validity of the FSM
# - Check if all transitions refer to existing states

execute store success score #s bs.ctx run function bs.fsm:check/well_formedness
# Also save the initial property in the initial state object
execute if score #s bs.ctx matches 1 run execute store success score #s bs.ctx run function bs.fsm:check/initiality
execute if score #s bs.ctx matches 1 store success score #s bs.ctx run function bs.fsm:check/unicity
# Need to be call before reachability, since this latter uses the finals states
execute if score #s bs.ctx matches 1 store success score #s bs.ctx run function bs.fsm:check/acceptability
execute if score #s bs.ctx matches 1 store success score #s bs.ctx run function bs.fsm:check/reachability

execute if score #s bs.ctx matches 0 run return fail

return 1
