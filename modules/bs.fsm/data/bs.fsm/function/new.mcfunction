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
# Macro: name: string
# Macro: fsm: {
#   initial: state
#   on_cancel?: command
#   states: [
#     {
#       name: string
#       on_tick?: command
#       on_exit?: command
#       on_enter?: command
#       final?: boolean
#       transitions?: [
#         {
#           name?: string
#           condition: 'manual' | { type: 'predicate', wait: string } | { type: 'command', wait: string } | { type: 'hook', wait: string } | { type: 'delay', wait: string }
#           to: state
#         }
#       ]
#     }
#   ]
# }

# Check if the FSM already exists.
$execute if data storage bs:data fsm.fsm.'$(name)' run function #bs.log:error { \
  namespace: bs.fsm, \
  path: "#bs.fsm:new", \
  tag: "new", \
  message: ["A FSM with the name '$(name)' already exists."] \
}
$execute if data storage bs:data fsm.fsm.'$(name)' run return fail

$data modify storage bs:ctx _ set value { fsm: $(fsm) }

# Check if the FSM is valid
execute store success score #s bs.ctx run function bs.fsm:check/is_valid
execute if score #s bs.ctx matches 0 run return fail

$data modify storage bs:data fsm.fsm.'$(name)' set value $(fsm)
data remove storage bs:ctx _
