# Input:
# Storage: bs:ctx _.states_to_browse (a list of states name)
# Storage: bs:ctx _.states_to_find (a list of states name)
# Storage: bs:ctx _.fsm (a FSM)

data modify storage bs:ctx _.current_state set from storage bs:ctx _.states_to_browse[-1]
function bs.fsm:check/internal/get_input_states with storage bs:ctx _
