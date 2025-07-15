$data modify storage bs:in string.to_list.str set value $(str)
function #bs.string:to_list
data modify storage bs:data regex.str set from storage bs:out string.to_list

execute store result score #l bs.ctx run data get storage bs:data regex.str
scoreboard players set #i bs.ctx 0
data modify storage bs:data regex.formatted set value []
