execute store result score #r bs.ctx run time query day
scoreboard players operation #r bs.ctx %= 8 bs.const
execute store result storage bs:ctx x int 1 run scoreboard players get #r bs.ctx
function bs.environment:celestial/get_phase with storage bs:ctx
