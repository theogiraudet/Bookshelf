# Input:
# Storage: bs:ctx _.fsm (a FSM)
# Macro: initial: state

# Output:
# Storage: bs:ctx _.initial (a state)
# Return 0 or 1 (0 if the state does not exist, 1 if it does)

data remove storage bs:ctx _.initial
$return run data modify storage bs:ctx _.initial set from storage bs:ctx _.fsm.states[{name: $(initial)}]
