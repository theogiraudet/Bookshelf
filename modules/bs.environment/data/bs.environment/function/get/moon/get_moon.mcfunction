execute store result score #result bs.ctx run time query day
scoreboard players operation #result bs.ctx %= 8 bs.const
execute store result storage bs:ctx _.index int 1 run scoreboard players get #result bs.ctx
function bs.environment:get/moon/get_moon_phase with storage bs:ctx _.index
