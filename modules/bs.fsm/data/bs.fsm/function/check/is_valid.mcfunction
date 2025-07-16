# Input:
# Storage: bs:ctx _.fsm (a FSM)

execute store success score #s bs.ctx run function bs.fsm:check/initiality
execute if score #s bs.ctx matches 1 store success score #s bs.ctx run function bs.fsm:check/unicity
# Need to be call before reachability, since this latter uses the finals states
execute if score #s bs.ctx matches 1 store success score #s bs.ctx run function bs.fsm:check/acceptability
execute if score #s bs.ctx matches 1 store success score #s bs.ctx run function bs.fsm:check/reachability

execute if score #s bs.ctx matches 0 run return fail

return 1
