# ⛰️ Environment

**`#bs.environment:help`**

Comprehensive information and tools related to weather and biome properties.

```{image} /_imgs/modules/environment.png
:width: 100%
:class: dark_light
```

```{epigraph}
"The most dangerous worldview is the worldview of those who have not viewed the world."

-- Alexander von Humboldt
```

---

## 🔧 Functions

You can find below all functions available in this module.

---

### Get Biome

```{function} #bs.environment:get_biome

Get biome data at the execution position of the function.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position from which you want to get biome data.

:Outputs:
  **Storage `bs:out environment.get_biome`**:
  :::{treeview}
  - {nbt}`compound` Biome data
    - {nbt}`string` **type**: String representation of the biome ID (e.g., `minecraft:plains`).
    - {nbt}`double` **temperature**: The base temperature of the biome.
    - {nbt}`bool` **has_precipitation**: Whether the biome has precipitation or not.
  :::
```

*Example: Get biome data at the current location:*

```mcfunction
# Once
function #bs.environment:get_biome
data get storage bs:out environment.get_biome
```

> **Credits**: Aksiome

---

### Get Temperature

```{function} #bs.environment:get_temperature {scale:<scaling>}

Get the temperature at the execution position of the function, taking the altitude into account.

:Inputs:
  **Execution `at <entity>` or `positioned <x> <y> <z>`**: Position from which you want to get the temperature.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: Scalar for the function's output.
  :::

:Outputs:
  **Return | Score `$environment.get_temperature bs.out`**: Temperature at the given position.
```

*Example: Get the temperature at the current altitude:*

```mcfunction
# Once
function #bs.environment:get_temperature {scale:1000}
```

> **Credits**: Aksiome, theogiraudet

---

### Celestial Movement

:::::{tab-set}
::::{tab-item} Get Current Sun Angle

```{function} #bs.environment:get_current_sun_angle

Get the current sun's angle on the Y axis relative to the horizon, in degrees.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: A scalar applied to the output.
  :::

:Outputs:
  **Return**: Sun's angle in degrees (scaled by `scale`). \
  **Storage `bs:out environment.celestial_angle`** {nbt}`double`: Sun's angle in degrees.
```

*Example: Get the sun's current angle:*

```mcfunction
# Once
function #bs.environment:get_sun_angle {scale: 1000}
tellraw @a [{"text":"Sun angle: "},{"nbt":"environment.celestial_angle","storage":"bs:out","interpret":true},{"text":"°"}]
```

```{admonition} doDaylightCycle gamerule
:class: info

This feature also works when the doDaylightCycle gamerule is set to false.
In such situation, the returned value is the sun's angle at the time of daylight cycle freeze.
```

::::
::::{tab-item} Get Current Moon Angle

```{function} #bs.environment:get_current_moon_angle

Get the current moon's angle on the Y axis relative to the horizon, in degrees.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`number` **scale**: A scalar applied to the output.
  :::

:Outputs:
  **Return**: Moon's angle in degrees (scaled by `scale`). \
  **Storage `bs:out environment.celestial_angle`** {nbt}`double`: Moon's angle in degrees.
```

*Example: Get the moon's current angle:*

```mcfunction
# Once
function #bs.environment:get_moon_angle {scale: 1000}
tellraw @a [{"text":"Moon angle: "},{"nbt":"environment.celestial_angle","storage":"bs:out","interpret":true},{"text":"°"}]

```{admonition} doDaylightCycle gamerule
:class: info

This feature also works when the doDaylightCycle gamerule is set to false.
In such situation, the returned value is the moon's angle at the time of daylight cycle freeze.
```

::::
::::{tab-item} Get Sun Angle

```{function} #bs.environment:get_sun_angle

Get the sun's angle on the Y axis relative to the horizon at a specific time.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **day**: The day number.
    - {nbt}`int` **daytime**: The time of day in ticks (0-24000).
    - {nbt}`number` **scale**: A scalar applied to the output.
  :::

:Outputs:
  **Return**: Sun's angle at the given time, in degrees (scaled by `scale`). \
  **Storage `bs:out environment.celestial_angle`** {nbt}`double`: Sun's angle in degrees.
```

*Example: Get the sun's angle on day 100 at noon (6000 ticks):*

```mcfunction
# Once
function #bs.environment:get_sun_angle {day: 100, daytime: 6000, scale: 1000}
tellraw @a [{"text":"Sun angle at day 100, noon: "},{"nbt":"environment.celestial_angle","storage":"bs:out","interpret":true},{"text":"°"}]
```

::::
::::{tab-item} Get Moon Angle

```{function} #bs.environment:get_moon_angle
Get the moon's angle on the Y axis relative to the horizon at a specific time.

:Inputs:
  **Function macro**:
  :::{treeview}
  - {nbt}`compound` Arguments
    - {nbt}`int` **day**: The day number.
    - {nbt}`int` **daytime**: The time of day in ticks (0-24000).
    - {nbt}`number` **scale**: A scalar applied to the output.
  :::

:Outputs:
  **Return**: Moon's angle at the given time, in degrees (scaled by `scale`). \
  **Storage `bs:out environment.celestial_angle`** {nbt}`double`: Moon's angle in degrees.
```

*Example: Get the moon's angle on day 100 at midnight (18000 ticks):*

```mcfunction
# Once
function #bs.environment:get_moon_angle {day:100, daytime:18000, scale: 1000}
tellraw @a [{"text":"Moon angle at day 100, midnight: "},{"nbt":"environment.celestial_angle","storage":"bs:out","interpret":true},{"text":"°"}]
```

::::
::::{tab-item} Look at Sun

```{function} #bs.environment:look_at_sun

Orient the executing entity to look at the sun.

:Inputs:
  **Execution `as <entity>`**: The entity to orient.

:Outputs:
  **State**: The entity's rotation is modified to face the sun.
```

*Example: Make the current entity look at the sun:*

```mcfunction
# Once
function #bs.environment:look_at_sun
```

::::
::::{tab-item} Look at Moon

```{function} #bs.environment:look_at_moon

Orient the executing entity to look at the moon.

:Inputs:
  **Execution `as <entity>`**: The entity to orient.

:Outputs:
  **State**: The entity's rotation is modified to face the moon.
```

*Example: Make the current entity look at the moon:*

```mcfunction
# Once
function #bs.environment:look_at_moon
```

::::
:::::

> **Credits**: theogiraudet

---

### Get Moon Phase

```{function} #bs.environment:get_moon_phase

Get the current moon phase as a string identifier.

:Outputs:
  **Storage `bs:out environment.get_moon_phase`**: {nbt}`string` Moon phase identifier. \
  **Return: Moon phase identifier (see the note below).
```

*Example: Get the current moon phase:*

```mcfunction
# Once
function #bs.environment:get_moon_phase
data get storage bs:out environment.get_moon_phase
```

```{admonition} Moon Phase Values
:class: note

The function returns one of the following string values:
- `"full_moon"` (id: 0)
- `"waning_gibbous"` (id: 1)
- `"third_quarter"` (id: 2)
- `"waning_crescent"` (id: 3)
- `"new_moon"` (id: 4)
- `"waxing_crescent"` (id: 5)
- `"first_quarter"` (id: 6)
- `"waxing_gibbous"` (id: 7)

The moon phase cycle follows Minecraft's 8-day lunar cycle.
```

> **Credits**: theogiraudet

---

## 👁️ Predicates

You can find below all predicates available in this module.

---

### Can It Rain?

**`bs.environment:can_rain`**

Determine if it can rain or not.

> **Credits**: Aksiome

---

### Can It Snow?

**`bs.environment:can_snow`**

Determine if it can snow or not.

> **Credits**: Aksiome

---

### Can It Rain or Snow?

**`bs.environment:has_precipitation`**

Determine if the biome has precipitation or not.

> **Credits**: Aksiome

---

### Is It Raining?

**`bs.environment:is_raining`**

Determine if it is currently raining or not.

> **Credits**: Aksiome, theogiraudet

---

### Is It Thundering?

**`bs.environment:is_thundering`**

Determine if it is currently thundering or not.

> **Credits**: Aksiome, theogiraudet

---

### Time Predicates

:::::{tab-set}
::::{tab-item} Day Time

**`bs.environment:is_day_time`**

Determine if it is currently daytime (between 07:00 and 18:00).

> **Credits**: theogiraudet

::::
::::{tab-item} Night Time

**`bs.environment:is_night_time`**

Determine if it is currently nighttime (between 19:00 and 06:00).

> **Credits**: theogiraudet

::::
::::{tab-item} Sunrise

**`bs.environment:is_sunrise_time`**

Determine if it is currently sunrise (between 06:00 and 07:00).

> **Credits**: theogiraudet

::::
::::{tab-item} Sunset

**`bs.environment:is_sunset_time`**

Determine if it is currently sunset (between 18:00 and 19:00).

> **Credits**: theogiraudet

::::
:::::

---

### Villager Behavior

:::::{tab-set}
::::{tab-item} Working

**`bs.environment:are_villagers_working`**

Determine if villagers are currently in their working phase (between 08:00 and 15:00).

> **Credits**: theogiraudet

::::
::::{tab-item} Socializing

**`bs.environment:are_villagers_socializing`**

Determine if villagers are currently in their socializing phase (between 15:00 and 18:00).

> **Credits**: theogiraudet

::::
::::{tab-item} Sleeping

**`bs.environment:are_villagers_sleeping`**

Determine if villagers are currently sleeping (between 18:00 and 07:00).

> **Credits**: theogiraudet

::::
:::::

---

### Can Bed Be Used?

**`bs.environment:can_bed_be_used`**

Determine if beds can currently be used by players (between 18:32 and 05:27 in clear weather, or 18:00 and 05:59 in rainy weather).

> **Credits**: theogiraudet

---

### Can Undeads Burn?

**`bs.environment:can_undeads_burn`**

Determine if undead mobs (zombies, skeletons, etc.) can currently burn in sunlight (between 05:27 and 18:32 in clear weather).

> **Credits**: theogiraudet

---

### Is Monsters Spawn Period?

**`bs.environment:is_monsters_spawn_period`**

Determine if hostile monsters can currently spawn outdoors (between 19:11 and 04:48 in clear weather, or 18:58 and 05:01 in rainy weather).

> **Credits**: theogiraudet

---

### Are Bees Sleeping?

**`bs.environment:are_bees_sleeping`**

Determine if bees are currently sleeping in their nests/hives (between 18:32 and 05:27 in clear weather).

> **Credits**: theogiraudet

---

### Is Creakings Spawn Period?

**`bs.environment:is_creakings_spawn_period`**

Determine if creakings can currently spawn (between 18:32 and 05:27 in clear weather, or 18:00 and 05:59 in rainy weather).

> **Credits**: theogiraudet

---

```{include} ../_templates/comments.md
```
