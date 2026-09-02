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

data remove storage bs:ward fsm.transitions

# A command transition is taken as soon as its command succeeds
function #bs.fsm:new { \
  name: "ward_command", \
  fsm: { \
    initial: "a", \
    states: [ \
      { \
        name: "a", \
        transitions: [{ \
          name: "go", \
          condition: { type: "command", wait: "data get storage bs:ward fsm.transitions.gate" }, \
          to: "b" \
        }] \
      }, \
      { name: "b", final: true } \
    ] \
  } \
}

# A predicate transition is taken as soon as its predicate passes
function #bs.fsm:new { \
  name: "ward_predicate", \
  fsm: { \
    initial: "a", \
    states: [ \
      { \
        name: "a", \
        transitions: [{ \
          name: "go", \
          condition: { type: "predicate", wait: "bs.fsm:test/always" }, \
          to: "b" \
        }] \
      }, \
      { name: "b", final: true } \
    ] \
  } \
}

## === COMMAND TRANSITION ===

function #bs.fsm:start { fsm_name: "ward_command", instance_name: "ward_command" }

# As long as the command fails, we stay in the current state
await delay 3t
assert data storage bs:data fsm.running_instances.ward_command.states[{name: "a", current: true}]

# Once the command succeeds, we move to the target state
data modify storage bs:ward fsm.transitions.gate set value 1
await data storage bs:data fsm.running_instances.ward_command.states[{name: "b", current: true}]

## === PREDICATE TRANSITION ===

function #bs.fsm:start { fsm_name: "ward_predicate", instance_name: "ward_predicate" }
await data storage bs:data fsm.running_instances.ward_predicate.states[{name: "b", current: true}]

## === CLEANUP ===

data remove storage bs:data fsm.running_instances.ward_command
data remove storage bs:data fsm.running_instances.ward_predicate
data remove storage bs:data fsm.fsm.ward_command
data remove storage bs:data fsm.fsm.ward_predicate
