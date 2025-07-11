execute store result storage bs:ctx y float 0.001 run function bs.environment:celestial/get_moon_angle
execute store result score #t bs.ctx run time query daytime
execute if score #t bs.ctx matches 6000..18000 run data modify storage bs:ctx x set value -90
execute unless score #t bs.ctx matches 6000..18000 run data modify storage bs:ctx x set value 90
function bs.environment:celestial/rotate with storage bs:ctx
