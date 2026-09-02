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

## === SETUP ===

data remove storage bs:ward fsm.start

function #bs.fsm:new { \
  name: "ward_start", \
  fsm: { \
    initial: "idle", \
    states: [ \
      { \
        name: "idle", \
        on_enter: "data modify storage bs:ward fsm.start append value entered_idle", \
        transitions: [{ name: "go", condition: "manual", to: "done" }] \
      }, \
      { name: "done", final: true } \
    ] \
  } \
}
assert data storage bs:data fsm.fsm.ward_start

## === UNKNOWN FSM ===

# Starting an instance of an FSM that was never registered must fail
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:start { fsm_name: "ward_unknown", instance_name: "ward_start" }
assert score #ward.fsm bs.ctx matches 0
assert not data storage bs:data fsm.running_instances.ward_start

## === GLOBAL INSTANCE ===

# Starting a known FSM registers the instance and enters the initial state
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:start { fsm_name: "ward_start", instance_name: "ward_start" }
assert not score #ward.fsm bs.ctx matches 0
assert data storage bs:data fsm.running_instances.ward_start
assert data storage bs:data fsm.running_instances.ward_start.states[{name: "idle", current: true}]
assert not data storage bs:data fsm.running_instances.ward_start.states[{name: "done", current: true}]

# The on_enter command of the initial state has been run in the global context
assert data storage bs:ward fsm{start: ["entered_idle"]}

## === DUPLICATE INSTANCE ===

# Starting a second instance under an already used name must fail
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:start { fsm_name: "ward_start", instance_name: "ward_start" }
assert score #ward.fsm bs.ctx matches 0
# The initial state must not have been entered a second time
assert data storage bs:ward fsm{start: ["entered_idle"]}

## === CLEANUP ===

data remove storage bs:data fsm.listened_transitions[{instance_name: "ward_start"}]
data remove storage bs:data fsm.ticks[{instance_name: "ward_start"}]
data remove storage bs:data fsm.running_instances.ward_start
data remove storage bs:data fsm.fsm.ward_start
