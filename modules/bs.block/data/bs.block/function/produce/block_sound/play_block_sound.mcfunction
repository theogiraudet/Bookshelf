# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/Bookshelf).
#
# This source code is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Conditions:
# - You may use this file in compliance with the MPL v2.0
# - Any modifications must be documented and disclosed under the same license
#
# For more details, refer to the MPL v2.0.
# ------------------------------------------------------------------------------------------------------------

data modify storage bs:ctx _ set value {}
data modify storage bs:ctx _.sounds set from storage bs:in block.play_block_sound.sounds
data modify storage bs:ctx _.sound_type set from storage bs:in block.play_block_sound.sound_type
data modify storage bs:ctx _.source set from storage bs:in block.play_block_sound.source
data modify storage bs:ctx _.targets set from storage bs:in block.play_block_sound.targets
data modify storage bs:ctx _.pos set from storage bs:in block.play_block_sound.pos
data modify storage bs:ctx _.volume set from storage bs:in block.play_block_sound.volume
data modify storage bs:ctx _.pitch set from storage bs:in block.play_block_sound.pitch
data modify storage bs:ctx _.min_volume set from storage bs:in block.play_block_sound.min_volume

function bs.block:produce/block_sound/get_sound with storage bs:ctx _
execute unless data storage bs:ctx _.sound run function #bs.log:error { namespace: "bs.block", path: "bs.block:produce/block_sound/play_block_sound", tag: "error", message: '[{"text":""},{"text":"Invalid sound type. Found "},{"nbt":"block.emit_block_sound.sound_type","storage":"bs:in","color":"red"},{"text":", "},{"text":"break","color":"dark_green"},{"text":", "},{"text":"hit","color":"dark_green"},{"text":", "},{"text":"fall","color":"dark_green"},{"text":", "},{"text":"place","color":"dark_green"},{"text":"or "},{"text":"step","color":"dark_green"},{"text":" expected."}]' }
execute unless data storage bs:ctx _.sound run return fail
function bs.block:produce/block_sound/run with storage bs:ctx _
