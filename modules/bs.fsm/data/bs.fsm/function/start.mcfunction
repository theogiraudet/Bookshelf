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
# Macro: fsm_name: string
# Macro: instance_name: string

$data modify storage bs:ctx _ set value { fsm_name: $(fsm_name), instance_name: $(instance_name) }

# We check if the instance already exists
$execute store success score #e bs.ctx if data storage bs:data fsm.running_instances.'$(instance_name)'
execute if score #e bs.ctx matches 1 run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:start", \
  tag: "start", \
  message: [{text: "An instance with the name '"}, {nbt: "_.instance_name", storage: "bs:ctx"}, {text: "' already exists in the global context."}] \
}
execute if score #e bs.ctx matches 1 run return fail

$execute store success score #s bs.ctx run data modify storage bs:data fsm.running_instances.'$(instance_name)' set from storage bs:data fsm.fsm.'$(fsm_name)'
execute if score #s bs.ctx matches 0 run function #bs.log:error { \
  namespace: "bs.fsm", \
  path: "#bs.fsm:start", \
  tag: "start", \
  message: [{text: "The FSM '"}, {nbt: "_.fsm_name", storage: "bs:ctx"}, {text: "' does not exist."}] \
}
execute if score #s bs.ctx matches 0 run return fail

# If the FSM is global, we enter the initial state
$data modify storage bs:ctx _.state_name set from storage bs:data fsm.fsm.'$(fsm_name)'.initial
function bs.fsm:run/enter_state_global with storage bs:ctx _
