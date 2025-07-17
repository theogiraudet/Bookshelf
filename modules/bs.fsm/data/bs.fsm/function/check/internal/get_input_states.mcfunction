# Input:
# Macro: $(current_state) (a state name)
# Storage: bs:ctx _.fsm (a FSM)

# Output:
# Storage: bs:ctx _.source_states (a list of states name)

data modify storage bs:ctx _.source_states set value []
$tellraw @a [{text: "current_state: "}, {text: "$(current_state)"}]
$data modify storage bs:ctx _.source_states append from storage bs:ctx _.fsm.states[{transitions: [{to: "$(current_state)"}]}]
