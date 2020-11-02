# How to make a new update

1. Make a new file with a copy of the content of the file `_example_update.html`. The new update file should follow the convention `YYYY-MM-DD.hmtl`.
2. Update the content of the new update file
3. Insert the new content into the update page by editing `updates.html` and put the below lines beneath the intro section with the new file name in the include line.
```
  <div class="ds-u-padding-y--2">
    {% include updates/YYYY-MM-DD.html %}
  </div>
```