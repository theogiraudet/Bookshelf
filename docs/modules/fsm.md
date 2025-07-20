# 🔄 FSM (Finite State Machine)

**`#bs.fsm:help`**

A powerful Finite State Machine (FSM) system for managing complex state-based behaviors in Minecraft.

```{epigraph}
FSMs are without a doubt the most commonly used technology in game AI programming today. 
They are conceptually simple, efficient, easily extensible, and yet powerful enough to handle a wide variety of situations.

-- Daniel D. Fu & Ryan Houlette
```

The FSM module provides a comprehensive system for creating, managing, and executing finite state machines. 
It allows you to define states, transitions, and behaviors in a declarative way, making complex state management simple and maintainable.

---

## 🔧 Functions

You can find below all functions available in this module.

---

### New

```{function} #bs.fsm:new

Create a new Finite State Machine (FSM) with the specified configuration.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **name**: Unique identifier for the FSM.
    - {nbt}`compound` **fsm**: FSM configuration object.
      - {nbt}`string` **initial**: Name of the initial state (must exist in states array).
      - {nbt}`string` **on_cancel**: Function to call when the FSM is cancelled (optional).
      - {nbt}`list` **states**: Array of state definitions.
        - {nbt}`compound` State
          - {nbt}`string` **name**: Unique name for the state.
          - {nbt}`string` **on_tick**: Function to call every tick while in this state (optional).
          - {nbt}`string` **on_enter**: Function to call when entering this state (optional).
          - {nbt}`string` **on_exit**: Function to call when exiting this state (optional).
          - {nbt}`bool` **final**: Whether this state is a final state (optional, default: false).
          - {nbt}`list` **transitions**: Array of transition definitions (optional).
            - {nbt}`compound` Transition
              - {nbt}`string` **name**: Name of the transition (optional).
              - {nbt}`string` {nbt}`compound` **condition**: Transition condition.
                - **"manual"**: Manual transition triggered by external call.
                - {nbt}`compound` **predicate**: Predicate-based transition.
                  - {nbt}`string` **type**: Must be "predicate".
                  - {nbt}`string` **wait**: Predicate to check to trigger the transition.
                - {nbt}`compound` **command**: Command-based transition.
                  - {nbt}`string` **type**: Must be "command".
                  - {nbt}`string` **wait**: Command to check to trigger the transition.
                - {nbt}`compound` **hook**: Hook-based transition.
                  - {nbt}`string` **type**: Must be "hook".
                  - {nbt}`string` **wait**: Hook function to evaluate.
                - {nbt}`compound` **delay**: Time-based transition.
                  - {nbt}`string` **type**: Must be "delay".
                  - {nbt}`string` **wait**: Time delay in ticks.
              - {nbt}`string` **to**: Name of the target state (must exist in states array).
  :::

:Outputs:
  **Return**: Success (1) if FSM was created successfully, failure (0) otherwise.

  **State**: The FSM is registered and available for use.
```

*Example: Create a simple door FSM with open/closed states:*

```mcfunction
# Create a door FSM
function #bs.fsm:new { \
  name: "door_fsm", \
  fsm: { \
    initial: "closed", \
    on_cancel: "bs.door:cancel", \
    states: [ \
      { \
        name: "closed", \
        on_tick: "bs.door:closed_tick", \
        on_enter: "bs.door:close_door", \
        on_exit: "bs.door:prepare_open", \
        transitions: [ \
          { \
            name: "open", \
            condition: "manual", \
            to: "opening" \
          } \
        ] \
      }, \
      { \
        name: "opening", \
        on_tick: "bs.door:opening_tick", \
        on_enter: "bs.door:start_opening", \
        on_exit: "bs.door:finish_opening", \
        transitions: [ \
          { \
            name: "opened", \
            condition: { type: "delay", wait: "20t" }, \
            to: "open" \
          } \
        ] \
      }, \
      { \
        name: "open", \
        on_tick: "bs.door:open_tick", \
        on_enter: "bs.door:open_door", \
        on_exit: "bs.door:prepare_close", \
        transitions: [ \
          { \
            name: "close", \
            condition: "manual", \
            to: "closing" \
          } \
        ] \
      }, \
      { \
        name: "closing", \
        on_tick: "bs.door:closing_tick", \
        on_enter: "bs.door:start_closing", \
        on_exit: "bs.door:finish_closing", \
        transitions: [ \
          { \
            name: "closed", \
            condition: { type: "delay", wait: "20t" }, \
            to: "closed" \
          } \
        ] \
      } \
    ] \
  } \
}
```

> **Credits**: theogiraudet

---

### Start

```{tab-set}
```{tab-item} Global Instance

```{function} #bs.fsm:start

Start a new global instance of a Finite State Machine.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **fsm_name**: Name of the FSM to instantiate (must exist).
    - {nbt}`string` **instance_name**: Unique identifier for this FSM instance.
  :::

:Outputs:
  **Return**: Success (1) if instance was started successfully, failure (0) otherwise.

  **State**: The FSM instance is created globally and begins execution in its initial state.
```

*Example: Start a door FSM instance:*

```mcfunction
# Start a door FSM instance
function #bs.fsm:start { fsm_name: "door_fsm", instance_name: "main_door" }

# The door FSM is now running globally and will execute its initial state
```

> **Credits**: theogiraudet

```

```{tab-item} Local Instance

```{function} #bs.fsm:start_as

Start new local instances of a Finite State Machine bound to the executing entities.

:Inputs:
  **Execution `as <entities>`**: Entities to bind. The entities must not be players.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **fsm_name**: Name of the FSM to instantiate (must exist).
    - {nbt}`string` **instance_name**: Unique identifier for this FSM instance.
  :::

:Outputs:
  **Return**: Success (1) if instance was started successfully, failure (0) otherwise.

  **State**: The FSM instances are created locally for the executing entities and begins execution in their initial state.
```

*Example: Start a door FSM instance for an entity:*

```mcfunction
# Start a door FSM instance bound to the executing entity
execute as @n[type=zombie] run function #bs.fsm:start_as { fsm_name: "door_fsm", instance_name: "entity_door" }

# The door FSM is now running locally for this zombie and will execute its initial state
```

> **Credits**: theogiraudet

```
```

---

### Cancel

```{function} #bs.fsm:cancel

Cancel and stop a running FSM instance.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **instance_name**: Name of the FSM instance to cancel.
    - {nbt}`string` **bind**: Binding type of the instance.
      - **"global"**: Instance is bound globally.
      - **"local"**: Instance is bound to the current execution context.
  :::

:Outputs:
  **Return**: Success (1) if instance was cancelled successfully, failure (0) otherwise.

  **State**: The FSM instance is stopped and cleaned up. If the FSM has an on_cancel function, it will be called.
```

*Example: Cancel a door FSM instance:*

```mcfunction
# Cancel the door FSM instance
function #bs.fsm:cancel { instance_name: "main_door", bind: "global" }

# The door FSM instance is now stopped
```

> **Credits**: theogiraudet

---

### Delete

```{function} #bs.fsm:delete

Delete a Finite State Machine definition and all its instances.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`string` **fsm_name**: Name of the FSM to delete.
  :::

:Outputs:
  **Return**: Success (1) if FSM was deleted successfully, failure (0) otherwise.

  **State**: The FSM definition and all its running instances are removed.
```

*Example: Delete a door FSM:*

```mcfunction
# Delete the door FSM
function #bs.fsm:delete { fsm_name: "door_fsm" }

# The door FSM and all its instances are now removed
```

> **Credits**: theogiraudet

---

## 📋 Validation Rules

The FSM system enforces several validation rules to ensure proper operation:

### Initiality
- The FSM must have an `initial` state specified
- The initial state must exist in the states array

### Unicity
- All state names must be unique within the FSM
- All transition names must be unique within a state (if specified)

### Acceptability
- The FSM must have at least one final state
- Final states are states marked with `final: true`

### Reachability
- All final states must be reachable from the initial state
- This is determined by analyzing the transition graph

### Transition Validation
- All transition target states must exist in the states array
- Transition conditions must be valid according to their type

---

## 🔄 State Lifecycle

Each state in an FSM follows a specific lifecycle:

1. **Enter**: The `on_enter` function is called when entering the state
2. **Tick**: The `on_tick` function is called every tick while in the state
3. **Transition**: When a transition condition is met, the state transitions
4. **Exit**: The `on_exit` function is called when leaving the state

---

## ⚡ Transition Types

The FSM system supports several types of transitions:

### Manual
Triggered by external function calls. Useful for player interactions or external events.

### Predicate
Triggered when a predicate function returns true. Useful for conditional logic.

### Function
Triggered when a function returns a specific value. Useful for complex conditions.

### Hook
Triggered by hook system events. Useful for integration with other systems.

### Delay
Triggered after a specified time delay. Useful for timed behaviors.

---

## 🎯 Use Cases

FSMs are particularly useful for:

- **Entity AI**: Managing complex behavior patterns
- **Machine States**: Controlling redstone contraptions
- **Game Mechanics**: Implementing complex game logic
- **UI Systems**: Managing interface states
- **Animation Systems**: Controlling entity animations
- **Quest Systems**: Managing quest progression

---

## ⚠️ Best Practices

1. **Keep states focused**: Each state should represent a single, well-defined behavior
2. **Use meaningful names**: State and transition names should clearly describe their purpose
3. **Handle edge cases**: Always consider what happens when transitions fail
4. **Clean up resources**: Use the on_exit functions to clean up state-specific resources
5. **Test thoroughly**: FSMs can become complex, so comprehensive testing is essential
6. **Document transitions**: Clearly document when and why transitions occur 
