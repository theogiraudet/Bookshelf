forceload add -30000000 1600

execute unless entity B5-0-0-0-1 run summon minecraft:marker -30000000 0 1600 {UUID:[I;181,0,0,1],Tags:["bs.entity","bs.persistent","smithed.entity","smithed.strict"]}
execute unless data storage bs:data fsm run data modify storage bs:data fsm set value { fsm: {}, running_instances: {} }
