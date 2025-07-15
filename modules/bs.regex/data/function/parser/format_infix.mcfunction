# Goal of the function: format an infix regex expression with '.' operator for concatenation
# Input:
# - bs:data regex.str: list of characters of the input regex
# - bs:data regex.formatted: list of characters of the formatted regex
# - #l bs.ctx: length of the input regex
# - #i bs.ctx: current index of the input regex
# Output:
# - bs:data regex.formatted: list of characters of the formatted regex

execute if score #i bs.ctx >= #l bs.ctx run return 1

# We add the current character to the formatted regex
data modify storage bs:data regex.formatted append from storage bs:data regex.str[0]
data modify storage bs:data regex.current append from storage bs:data regex.str[0]

# We shift the input regex to have access to the next character
scoreboard players add #i bs.ctx 1
data remove storage bs:data regex.str[0]

# If the next character exists, we keep it
execute if score #i bs.ctx < #l bs.ctx run data modify storage bs:ctx _ set from storage bs:data regex.str[0]
