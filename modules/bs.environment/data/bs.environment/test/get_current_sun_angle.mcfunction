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

## === TEST get_current_sun_angle ===

# Test sunrise (06:00 - 0 ticks)
time set 0t
await delay 5t
function #bs.environment:get_current_sun_angle
# At sunrise, sun angle should be around 0° (horizon)
assert score $environment.get_sun_angle bs.out matches -5000..5000

# Test morning (07:00 - 1000 ticks)
time set 1000t
await delay 5t
function #bs.environment:get_current_sun_angle
# At morning, sun angle should be around 15° (rising)
assert score $environment.get_sun_angle bs.out matches 10000..20000

# Test noon (12:00 - 6000 ticks)
time set 6000t
await delay 5t
function #bs.environment:get_current_sun_angle
# At noon, sun angle should be around -90° (zenith)
assert score $environment.get_sun_angle bs.out matches -95000..-85000

# Test afternoon (15:00 - 9000 ticks)
time set 9000t
await delay 5t
function #bs.environment:get_current_sun_angle
# At afternoon, sun angle should be around 15° (setting)
assert score $environment.get_sun_angle bs.out matches 10000..20000

# Test sunset (18:00 - 12000 ticks)
time set 12000t
await delay 5t
function #bs.environment:get_current_sun_angle
# At sunset, sun angle should be around 0° (horizon)
assert score $environment.get_sun_angle bs.out matches -5000..5000

# Test night (19:00 - 13000 ticks)
time set 13000t
await delay 5t
function #bs.environment:get_current_sun_angle
# At night, sun angle should be around -15° (below horizon)
assert score $environment.get_sun_angle bs.out matches -20000..-10000

# Test midnight (00:00 - 18000 ticks)
time set 18000t
await delay 5t
function #bs.environment:get_current_sun_angle
# At midnight, sun angle should be around -90° (below horizon)
assert score $environment.get_sun_angle bs.out matches -95000..-85000

# Test early morning (04:18 - 22300 ticks)
time set 22300t
await delay 5t
function #bs.environment:get_current_sun_angle
# At early morning, sun angle should be around -15° (below horizon)
assert score $environment.get_sun_angle bs.out matches -20000..-10000 
