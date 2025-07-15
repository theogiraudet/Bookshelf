# ------------------------------------------------------------------------------------------------------------
# Copyright (c) 2025 Gunivers
#
# This file is part of the Bookshelf project (https://github.com/mcbookshelf/bookshelf).
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
# @dummy

## === TEST get_current_moon_angle ===

# Test beggining of the sunset (18:00 - 12000 ticks, moon rises when sun sets)
time set 12000t
await delay 10t
function #bs.environment:get_current_moon_angle
# At moonrise, moon angle should be around 12° (rising)
assert score $environment.get_moon_angle bs.out matches 7000..17000

# Test moon at beggining of the night, moon is visible (19:00 - 13000 ticks)
time set 13000t
await delay 10t
function #bs.environment:get_current_moon_angle
# At night, moon angle should be around -3° (horizon)
assert score $environment.get_moon_angle bs.out matches -8000..2000

# Test moon at midnight (00:00 - 18000 ticks)
time set 18000t
await delay 10t
function #bs.environment:get_current_moon_angle
# At midnight, moon angle should be around -90° (zenith)
assert score $environment.get_moon_angle bs.out matches -95000..-85000

# Test moon at early morning (04:18 - 22300 ticks)
time set 22300t
await delay 10t
function #bs.environment:get_current_moon_angle
# At early morning, moon angle should be around -15° (setting)
assert score $environment.get_moon_angle bs.out matches -20000..-10000

# Test moonset (06:00 - 0 ticks, moon sets when sun rises)
time set 0t
await delay 10t
function #bs.environment:get_current_moon_angle
# At moonset, moon angle should be around 12° (below horizon)
assert score $environment.get_moon_angle bs.out matches 7000..17000

# Test moon at morning (07:00 - 1000 ticks)
time set 1000t
await delay 10t
function #bs.environment:get_current_moon_angle
# At morning, moon angle should be around 27° (below horizon)
assert score $environment.get_moon_angle bs.out matches 22000..32000

# Test moon at noon (12:00 - 6000 ticks)
time set 6000t
await delay 10t
function #bs.environment:get_current_moon_angle
# At noon, moon angle should be around 90° (below horizon)
assert score $environment.get_moon_angle bs.out matches 85000..95000

# Test moon at afternoon (15:00 - 9000 ticks)
time set 9000t
await delay 10t
function #bs.environment:get_current_moon_angle
# At afternoon, moon angle should be around 55° (below horizon)
assert score $environment.get_moon_angle bs.out matches -60000..-50000
