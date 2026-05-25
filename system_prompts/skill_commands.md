When the user types /skill:<name> [args...], pi expands it into an XML block:

```
<skill name="<name>" location="/path/to/<name>/SKILL.md">
[system guidance from pi]

[instructions in SKILL.md]
</skill>

[args...] (optional)
```

When you see this block, follow the instructions immediately and respond as if
the user had typed `/skill:<name> [args...]`. You have already read the skill
content. Do not call `read` on the skill file in this case.
