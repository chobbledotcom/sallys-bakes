# Editing Ingredients

The ingredients content is written in Markdown - [click here for a Markdown formatting guide](https://www.markdownguide.org/cheat-sheet/)

To add a new item, cick "Add File > New File", and give it a name in lower case, with dashes instead of spaces, and ending in `.md`, like: `pepper-steak-bake.md`

Each ingredient list should start with three dashes, the title of the item, and then three more dashes.

To include the pastry ingredients on a page, you can type: `{%- include_relative pastry.md %}` - this saves having to write them out each time.

To edit the pastry ingredients, [click here](pastry.md).

Highlight allergens by surrounding them with two asterisks, like `**this**`

Example content:

```
---
title: Lovely pasty
---

A delicious pasty made with love and care!

{%- include_relative pastry.md %}

## Filling:

- Love
- **Wheat gluten**
- Care
```
