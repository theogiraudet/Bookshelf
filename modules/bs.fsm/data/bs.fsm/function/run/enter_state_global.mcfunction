# Input:
# - Macro instance_name: string
# - Macro state_name: string - new current state name

# We set the new state as current state
$data modify storage bs:data fsm.running_instances.'$(instance_name)'.states[{name: "$(state_name)"}].current set value true

$data modify storage bs:ctx _.state set from storage bs:data fsm.running_instances.'$(instance_name)'.states[{name: "$(state_name)"}]

# We prepare the transitions to be listened
data modify storage bs:ctx _.tmp set from storage bs:ctx _.state.transitions
data modify storage bs:ctx _.tmp[].source set from storage bs:ctx _.state.name
data modify storage bs:ctx _.tmp[].context set value "global"
$execute if data storage bs:ctx _.state.on_tick run data modify storage bs:ctx _.tmp.instance_name set value "$(instance_name)"

# We add the transitions to the listened transitions list
data modify storage bs:data fsm.listened_transitions append from storage bs:ctx _.tmp[]

# We execute the on_enter command
execute if data storage bs:ctx _.state.on_enter run data modify storage bs:ctx _.command set from storage bs:ctx _.state.on_enter
execute if data storage bs:ctx _.state.on_enter run function bs.fsm:run/run_command_global with storage bs:ctx _

# We register the on_tick command
execute if data storage bs:ctx _.state.on_tick run data modify storage bs:ctx _.tmp set value {}
execute if data storage bs:ctx _.state.on_tick run data modify storage bs:ctx _.tmp.command set from storage bs:ctx _.state.on_tick
$execute if data storage bs:ctx _.state.on_tick run data modify storage bs:ctx _.tmp.instance_name set value "$(instance_name)"
execute if data storage bs:ctx _.state.on_tick run data modify storage bs:data fsm.ticks append from storage bs:ctx _.tmp
# If this is the only command on the ticks list, we start the tick loop
execute unless data storage bs:data fsm.ticks[1] run schedule function bs.fsm:run/tick 1t
