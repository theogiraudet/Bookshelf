# Input:
# Storage: bs:ctx _.fsm (a FSM)

# Output:
# Storage: bs:ctx _.finals (a list of states)
# Return 0 or 1 (0 if the FSM is not acceptable, 1 if it is)

data modify storage bs:ctx _.finals set value []
data modify storage bs:ctx _.finals append from storage bs:ctx _.fsm.states[{final: true}]
return run execute if data storage bs:ctx _.finals[0]
