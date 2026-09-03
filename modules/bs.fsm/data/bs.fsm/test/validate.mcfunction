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

data remove storage bs:ward fsm.templates.validate

## === UNKNOWN TEMPLATE ===

# Validating a path holding no template must fail
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.ward_unknown" }
assert score #ward.fsm bs.ctx matches 0

## === VALID TEMPLATE ===

data modify storage bs:ward fsm.templates.validate.valid set value { \
  initial: "idle", \
  on_cancel: "bs.fsm:test/cancel", \
  states: [ \
    { \
      name: "idle", \
      on_tick: "bs.fsm:test/tick", \
      on_enter: "bs.fsm:test/enter", \
      on_exit: "bs.fsm:test/exit", \
      transitions: [{ name: "start", condition: "manual", to: "active" }] \
    }, \
    { name: "active", final: true } \
  ] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.valid" }
assert not score #ward.fsm bs.ctx matches 0


## === MINIMAL TEMPLATE ===

data modify storage bs:ward fsm.templates.validate.minimal set value { \
  initial: "state1", \
  states: [{ name: "state1", final: true }] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.minimal" }
assert not score #ward.fsm bs.ctx matches 0

## === TEMPLATE WITH EVERY TRANSITION TYPE ===

data modify storage bs:ward fsm.templates.validate.complex set value { \
  initial: "start", \
  states: [ \
    { \
      name: "start", \
      transitions: [ \
        { name: "manual_transition", condition: "manual", to: "waiting" }, \
        { name: "predicate_transition", condition: { type: "predicate", wait: "bs.fsm:test/always" }, to: "processing" }, \
        { name: "command_transition", condition: { type: "command", wait: "bs.fsm:test/function" }, to: "processing" }, \
        { name: "hook_transition", condition: { type: "hook", wait: "bs.fsm:test/hook" }, to: "processing" }, \
        { name: "delay_transition", condition: { type: "delay", wait: 20 }, to: "processing" } \
      ] \
    }, \
    { \
      name: "waiting", \
      transitions: [{ name: "manual_transition", condition: "manual", to: "processing" }] \
    }, \
    { name: "processing", final: true } \
  ] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.complex" }
assert not score #ward.fsm bs.ctx matches 0

## === NO INITIAL STATE ===

data modify storage bs:ward fsm.templates.validate.no_initial set value { \
  states: [{ name: "idle", final: true }] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.no_initial" }
assert score #ward.fsm bs.ctx matches 0

## === UNKNOWN INITIAL STATE ===

data modify storage bs:ward fsm.templates.validate.bad_initial set value { \
  initial: "nonexistent", \
  states: [{ name: "idle", final: true }] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.bad_initial" }
assert score #ward.fsm bs.ctx matches 0

## === DUPLICATE STATE NAMES ===

data modify storage bs:ward fsm.templates.validate.duplicate set value { \
  initial: "idle", \
  states: [{ name: "idle", final: true }, { name: "idle", final: true }] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.duplicate" }
assert score #ward.fsm bs.ctx matches 0

## === TRANSITION TO AN UNKNOWN STATE ===

data modify storage bs:ward fsm.templates.validate.bad_transition set value { \
  initial: "idle", \
  states: [ \
    { \
      name: "idle", \
      transitions: [ \
        { condition: "manual", to: "nonexistent" }, \
        { condition: "manual", to: "active" } \
      ] \
    }, \
    { name: "active", final: true } \
  ] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.bad_transition" }
assert score #ward.fsm bs.ctx matches 0

## === UNREACHABLE FINAL STATE ===

data modify storage bs:ward fsm.templates.validate.unreachable set value { \
  initial: "idle", \
  states: [{ name: "idle", final: false }, { name: "final_state", final: true }] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.unreachable" }
assert score #ward.fsm bs.ctx matches 0

## === NO FINAL STATE ===

data modify storage bs:ward fsm.templates.validate.no_final set value { \
  initial: "idle", \
  states: [ \
    { name: "idle", transitions: [{ condition: "manual", to: "active" }] }, \
    { name: "active", final: false } \
  ] \
}
scoreboard players set #ward.fsm bs.ctx -1
execute store success score #ward.fsm bs.ctx run function #bs.fsm:validate { uses: "bs:ward fsm.templates.validate.no_final" }
assert score #ward.fsm bs.ctx matches 0

## === CLEANUP ===

data remove storage bs:ward fsm.templates.validate
