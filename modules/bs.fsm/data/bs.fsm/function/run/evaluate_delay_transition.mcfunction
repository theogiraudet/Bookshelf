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

# We check if the delay has passed, if so, we switch to the target state. Otherwise, we decrease the delay
execute store result score #d bs.ctx run data get storage bs:data fsm.listened_transitions[0].condition.wait
execute if score #d bs.ctx matches ..0 run function bs.fsm:run/switch_state with storage bs:data fsm.listened_transitions[0]
execute if score #d bs.ctx matches ..0 run return 1
execute if score #d bs.ctx matches 1.. run scoreboard players remove #d bs.ctx 1
execute store result storage bs:data fsm.listened_transitions[0].condition.wait int 1 run scoreboard players get #d bs.ctx

return fail
