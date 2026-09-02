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

data remove storage bs:ward fsm.local

# The FSM is bound to an entity: its commands and predicates run as and at it
function #bs.fsm:new { \
  name: "ward_local", \
  fsm: { \
    initial: "a", \
    states: [ \
      { \
        name: "a", \
        on_enter: "tag @s add bs.ward.fsm_in_a", \
        transitions: [{ \
          name: "go", \
          condition: { type: "predicate", wait: "bs.fsm:test/always" }, \
          to: "b" \
        }] \
      }, \
      { \
        name: "b", \
        on_enter: "tag @s add bs.ward.fsm_in_b", \
        on_tick: "data modify storage bs:ward fsm.local.ticks append value 1", \
        transitions: [{ name: "never", condition: { type: "delay", wait: 1000 }, to: "c" }] \
      }, \
      { name: "c", final: true } \
    ] \
  } \
}

summon minecraft:marker ~ ~ ~ {Tags: ["bs.ward.fsm_local"]}

## === UNKNOWN FSM ===

# Binding an FSM that was never registered must fail
scoreboard players set #ward.fsm bs.ctx -1
execute as @e[type=minecraft:marker,tag=bs.ward.fsm_local,limit=1] at @s store success score #ward.fsm bs.ctx run function #bs.fsm:start_as { fsm_name: "ward_unknown", instance_name: "ward_local" }
assert score #ward.fsm bs.ctx matches 0
assert not data entity @e[type=minecraft:marker,tag=bs.ward.fsm_local,limit=1] data.bs:fsm.running_instances.ward_local

## === LOCAL INSTANCE ===

# The instance is stored on the entity and its initial state is entered as it
scoreboard players set #ward.fsm bs.ctx -1
execute as @e[type=minecraft:marker,tag=bs.ward.fsm_local,limit=1] at @s store success score #ward.fsm bs.ctx run function #bs.fsm:start_as { fsm_name: "ward_local", instance_name: "ward_local" }
assert not score #ward.fsm bs.ctx matches 0
assert data entity @e[type=minecraft:marker,tag=bs.ward.fsm_local,limit=1] data.bs:fsm.running_instances.ward_local.states[{name: "a", current: true}]
assert entity @e[type=minecraft:marker,tag=bs.ward.fsm_local,tag=bs.ward.fsm_in_a]

## === DUPLICATE INSTANCE ===

# Binding a second instance under an already used name must fail
scoreboard players set #ward.fsm bs.ctx -1
execute as @e[type=minecraft:marker,tag=bs.ward.fsm_local,limit=1] at @s store success score #ward.fsm bs.ctx run function #bs.fsm:start_as { fsm_name: "ward_local", instance_name: "ward_local" }
assert score #ward.fsm bs.ctx matches 0

## === LOCAL PREDICATE TRANSITION AND TICK ===

# The predicate is evaluated as the bound entity, then the target state is entered as it
await entity @e[type=minecraft:marker,tag=bs.ward.fsm_local,tag=bs.ward.fsm_in_b]
await data storage bs:ward fsm.local.ticks[1]

## === BOUND ENTITY REMOVAL ===

# Killing the entity stops its tick commands and its transitions evaluation
kill @e[type=minecraft:marker,tag=bs.ward.fsm_local]
await not data storage bs:data fsm.ticks[{instance_name: "ward_local"}]
await not data storage bs:data fsm.listened_transitions[{instance_name: "ward_local"}]

## === CLEANUP ===

data remove storage bs:data fsm.fsm.ward_local
