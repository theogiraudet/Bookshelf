# 👆 Component

**`#bs.component:help`**

Create easily graphical components in Minecraft.

```{epigraph}
"About ten years ago, most push buttons went "3D". Using shades of grey, they appear to pop out of the screen. This is not just to look cool: it's important because 3D buttons afford pushing."

-- joel Spolsky
```

The Component API is a high-level API to create GUIs components.
This API use the Interaction API under the hood to create the components and the events.
You can so fallback on the Interaction API to create more complex components.

---

## 🔧 Functions

You can find below all functions available in this API.

---

### Create Button

:::::{tab-set}
::::{tab-item} Block Display Button

```{function} #bs.component:create_block_button

Create a button represented by a block display.
The button trigger a given event when left clicked and by default glows when hovered and plays a sound when clicked.

:Inputs:
  **Execution `at <position>`**: The position of the button.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`float` **width**: The width of the button. This will also be used as the width of the interaction hitbox.
    - {nbt}`float` **height**: The height of the button. This will also be used as the width of the interaction hitbox.
    - {nbt}`string` **on_click**: The event to trigger when the button is left clicked.
    - {nbt}`string` **block**: The block to use to display the button.
    - {nbt}`compound` **properties**: The properties of the block to display. Same as block display NBT `properties`.
    - {nbt}`compound` **with**: Optional parameters.
      - {nbt}`string` **hover**: The event to trigger when the button is hovered. Glow the block by default.
      - {nbt}`string` **hover_leave**: The event to trigger when the mouse leave the button. Unglow the block by default.
      - {nbt}`bool` **click_sound**: If false, disable the click sound.
      - {nbt}`compound` **display_data**: the display data. See Display format in the Minecraft Wiki.
  :::

:Outputs:
  **State**: A clickable button, represented by the defined block display.
```

*Add a new button represented by a 1×1 slime block that trigger "say Clicked" when clicked:*

```mcfunction
function #bs.component:create_block_button { width: 1f, height: 1f, on_click: "say Clicked", block: "minecraft:slime_block", properties: {}, with: {} }

# Same command but with more readable syntax
function #bs.component:create_block_button { \
  width: 1f, \
  height: 1f, \
  on_click: "say Clicked", \
  block: "minecraft:slime_block", \
  properties: {}, \
  with: {} \
}
```
::::
::::{tab-item} Item Display Button

```{function} #bs.component:create_item_button

Create a button represented by an item display.
The button trigger a given event when left clicked and by default glows when hovered and plays a sound when clicked.

:Inputs:
  **Execution `at <position>`**: The position of the button.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`float` **width**: The width of the button. This will also be used as the width of the interaction hitbox.
    - {nbt}`float` **height**: The height of the button. This will also be used as the width of the interaction hitbox.
    - {nbt}`string` **on_click**: The event to trigger when the button is left clicked.
    - {nbt}`string` **item**: The item to use to display the button.
    - {nbt}`compound` **with**: Optional parameters.
      - {nbt}`string` **hover**: The event to trigger when the button is hovered. Glow the item by default.
      - {nbt}`string` **hover_leave**: The event to trigger when the mouse leave the button. Unglow the item by default.
      - {nbt}`bool` **click_sound**: If false, disable the click sound.
      - {nbt}`string` **item_display**: The model to display. Can be `none`, `thirdperson_lefthand`, `thirdperson_righthand`, `firstperson_lefthand`, `firstperson_righthand`, `head`, `gui`, `ground`, or `fixed`. Defaults to `none`.
      - {nbt}`compound` **item**: the properties of the item to display. Empty by default.
        - {nbt}`compound` **components**: the data components of the item. See Data component format in the Minecraft Wiki.
      - {nbt}`compound` **display_data**: the display data. See Display format in the Minecraft Wiki.
  :::

:Outputs:
  **State**: A clickable button, represented by the defined item display.
```

*Add a new button represented by a 1×1 slimeball that trigger "say Clicked" when clicked:*

```mcfunction
function #bs.component:create_item_button { width: 1f, height: 1f, on_click: "say Clicked", item: "minecraft:slimeball", with: {} }

# Same command but with more readable syntax
function #bs.component:create_item_button { \
  width: 1f, \
  height: 1f, \
  on_click: "say Clicked", \
  item: "minecraft:slimeball", \
  with: {} \
}
```
::::
::::{tab-item} Text Display Button

```{function} #bs.component:create_text_button

Create a button represented by an text display.
The button trigger a given event when left clicked and by default glows when hovered and plays a sound when clicked.

:Inputs:
  **Execution `at <position>`**: The position of the button.

  **Function macro**:
  :::{treeview}
  - {nbt}`compound` **Arguments**:
    - {nbt}`float` **width**: The width of the button. This will also be used as the width of the interaction hitbox.
    - {nbt}`float` **height**: The height of the button. This will also be used as the width of the interaction hitbox.
    - {nbt}`string` **on_click**: The event to trigger when the button is left clicked.
    - {nbt}`string` **text**: The text to display on the button. Should be a raw JSON text (see Text component format in the Minecraft Wiki).
    - {nbt}`compound` **with**: Optional parameters.
      - {nbt}`string` **hover**: The event to trigger when the button is hovered. Glow the text by default.
      - {nbt}`string` **hover_leave**: The event to trigger when the mouse leave the button. Unglow the text by default.
      - {nbt}`bool` **click_sound**: If false, disable the click sound.
      - {nbt}`string` **alignment**: The alignment of the text. Can be `center`, `left`, or `right`. Defaults to `center`.
      - {nbt}`int` **background**: The background color of the text. Default to `1073741824`.
      - {nbt}`bool` **default_background**: If true, use the default background color. Defaults to `false`.
      - {nbt}`int` **line_width**: The maximum width of the text (note: new line can be also added with `\n` characters). Defaults to `200`.
      - {nbt}`bool` **see_through**: If true, the text can be seen through blocks. Defaults to `false`.
      - {nbt}`bool` **shadow**: If true, the text has a shadow. Defaults to `false`.
      - {nbt}`int` **text_opacity**: The opacity of the text. Default to `255` (completely opaque).
      - {nbt}`compound` **display_data**: the display data. See Display format in the Minecraft Wiki.
  :::

:Outputs:
  **State**: A clickable button, represented by the defined text display.
```

*Add a new button represented by the "Hello World!" text that trigger "say Hello World!" when clicked:*

```mcfunction
function #bs.component:create_text_button { width: 1f, height: 1f, on_click: "say Hello World!", text: "Hello World!", with: {} }

# Same command but with more readable syntax
function #bs.component:create_text_button { \
  width: 1f, \
  height: 1f, \
  on_click: "say Hello World!", \
  text: "Hello World!", \
  with: {} \
}
```
::::
:::::

> **Credits**: theogiraudet

---

<div id="gs-comments" align=center>

**💬 Did it help you?**

Feel free to leave your questions and feedbacks below!

</div>
