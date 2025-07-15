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

## === TEST get_moon_angle ===

# Test moon angle at specific time: day 100, moonrise (18:00 - 12000 ticks)
function #bs.environment:get_moon_angle {day:100, daytime:12000}
# At moonrise, moon angle should be around 0° (horizon)
assert score $environment.get_moon_angle bs.out matches -5000..5000

# Test moon angle at specific time: day 50, night (19:00 - 13000 ticks)
function #bs.environment:get_moon_angle {day:50, daytime:13000}
# At night, moon angle should be around 15° (rising)
assert score $environment.get_moon_angle bs.out matches 10000..20000

# Test moon angle at specific time: day 200, midnight (00:00 - 18000 ticks)
function #bs.environment:get_moon_angle {day:200, daytime:18000}
# At midnight, moon angle should be around -90° (zenith, opposite to sun)
assert score $environment.get_moon_angle bs.out matches -95000..-85000

# Test moon angle at specific time: day 75, early morning (04:18 - 22300 ticks)
function #bs.environment:get_moon_angle {day:75, daytime:22300}
# At early morning, moon angle should be around 15° (setting)
assert score $environment.get_moon_angle bs.out matches 10000..20000

# Test moon angle at specific time: day 150, moonset (06:00 - 0 ticks)
function #bs.environment:get_moon_angle {day:150, daytime:0}
# At moonset, moon angle should be around 0° (horizon)
assert score $environment.get_moon_angle bs.out matches -5000..5000

# Test moon angle at specific time: day 25, morning (07:00 - 1000 ticks)
function #bs.environment:get_moon_angle {day:25, daytime:1000}
# At morning, moon angle should be around -15° (below horizon)
assert score $environment.get_moon_angle bs.out matches -20000..-10000

# Test moon angle at specific time: day 300, noon (12:00 - 6000 ticks)
function #bs.environment:get_moon_angle {day:300, daytime:6000}
# At noon, moon angle should be around 90° (below horizon, opposite to sun)
assert score $environment.get_moon_angle bs.out matches 85000..95000

# Test moon angle at specific time: day 80, afternoon (15:00 - 9000 ticks)
function #bs.environment:get_moon_angle {day:80, daytime:9000}
# At afternoon, moon angle should be around -15° (below horizon)
assert score $environment.get_moon_angle bs.out matches -20000..-10000 
