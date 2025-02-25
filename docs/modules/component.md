# 👆 Component

**`#bs.component:help`**

Create easily graphical components in Minecraft.

```{epigraph}
"About ten years ago, most push buttons went “3D”. Using shades of grey, they appear to pop out of the screen. This is not just to look cool: it’s important because 3D buttons afford pushing."

-- joel Spolsky
```

The Component API is a high-level API to create GUIs components.
This API use the Interaction API under the hood to create the components and the events.
You can so fallback on the Interaction API to create more complex components.

---

## 🔧 Functions

You can find below all functions available in this API.

---

### Clear Events

```{function} #bs.interaction:clear_events

Clear events registered for the specified interaction entity.

:Inputs:
  **Execution `as <entity>`**: Interaction entity for which the events will be cleared.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`compound` **with**: Parameters to filter which events to clear. Clear all events if empty.
      - {nbt}`string` **type**: Specify the type of events to clear.
      - {nbt}`int` **id**: Specify the ID of events to clear.
  :::

:Outputs:
  **Return**: The number of events removed.

  **State**: The specified events for the interaction entity will be removed.
```

*Clear hover events for the interaction entity:*

```mcfunction
summon minecraft:interaction ~ ~ ~ { Tags: ["bs.entity.interaction"], width: 1f, height: 1f }

# Register hover events for the interaction
execute as @n[tag=bs.entity.interaction] run function #bs.interaction:on_hover { run: "say Hovered", executor: "target" }

# Clear hover events for the interaction
execute as @n[tag=bs.entity.interaction] run function #bs.interaction:clear_events { with: { type: "hover" } }
```

> **Credits**: theogiraudet

---

<div id="gs-comments" align=center>

**💬 Did it help you?**

Feel free to leave your questions and feedbacks below!

</div>
