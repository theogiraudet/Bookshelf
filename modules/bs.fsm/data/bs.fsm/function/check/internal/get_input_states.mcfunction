# Input:
# Macro: $(current_state) (a state name)
# Storage: bs:ctx _.fsm (a FSM)

data modify storage bs:ctx _.source_states set value []
$data modify storage bs:ctx _.source_states append from storage bs:ctx _.fsm.states[{transitions: [{to: $(current_state)}]}]
