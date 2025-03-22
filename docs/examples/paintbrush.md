```{include} ../../examples/paintbrush.md
```

---

```{include} ../_templates/comments.md
```

*Exemple: Create a paintbrush that changes block materials:*

```mcfunction
# Once
function #bs.paintbrush:create {block:"minecraft:oak_planks"}

# See the result
# Right-click on blocks to change their material
```

*Exemple: Create a paintbrush with custom properties:*

```mcfunction
# Once
function #bs.paintbrush:create {block:"minecraft:stone", durability:100, cooldown:20}

# See the result
# Right-click on blocks to change their material
```

*Exemple: Remove a paintbrush:*

```mcfunction
# Once
function #bs.paintbrush:remove

# See the result
# The paintbrush has been removed from your inventory
```
