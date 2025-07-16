# Input:
# Storage: bs:ctx _.fsm (a FSM)
# Storage: bs:ctx _.finals (a list of states)
# Storage: bs:ctx _.initial (a state)

# Storage: bs:ctx _.found_states (a list of states name)

data modify storage bs:ctx _.non_final_states set value []
data modify storage bs:ctx _.non_final_states append from storage bs:ctx _.fsm.states[]
data remove storage bs:ctx _.non_final_states[{final: true}]

data modify storage bs:ctx _.states_to_find set value []
data modify storage bs:ctx _.states_to_find append from storage bs:ctx _.non_final_states[].name

data modify storage bs:ctx _.states_to_browse set value []
data modify storage bs:ctx _.states_to_browse append from storage bs:ctx _.finals[].name
