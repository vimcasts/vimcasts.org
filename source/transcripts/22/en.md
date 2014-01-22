Abstract
========

If you want to edit several adjacent lines with a similar format, you might save a lot of time by making a columnar selection. This episode will demonstrate how to achieve this using Vim's visual block mode.

Body
====

In TextMate you can toggle between character selection and columnar selection by pressing the 'option' key. Any characters typed now will be entered simultaneously in each selected line. This is a really powerful technique. Once you've got the hang of it, it becomes difficult to take seriously any text editor which doesn't offer some form of column select mode.

In Vim, this functionality goes under the name of [*visual block mode*][v_block]. From normal mode, you can enter visual block mode by pressing `ctrl-v`. You can move the cursor around with all of the usual motion commands, creating a rectangular selection. Now you can enter insert mode by pressing 'shift-I'. Any characters typed will be inserted at the top of the selection that was made. When you leave insert mode, by pressing escape, the text that you entered will be inserted at the beginning of each line of the selection.

In most text editing environments, if you want to replace some text, you can just start typing and the replacement will overwrite the selection. But Vim's visual modes are similar to normal mode, in that each key will execute a command. If you want to replace a selection made in visual mode, you can press the `c` key. Just like in normal mode, this performs a delete operation and leaves you in insert mode. You can see the effect of the deletion immediately, but once again, you have to leave insert mode to see the text you typed being applied to each line.

In Vim, there is always the choice between `i` to insert in front of the cursor, and `a` to append after the cursor position. This holds true in visual block mode too. Here, I have made a column selection of width 1. If I press shift-A, I can append text after the column. If I press shift-I instead, I can insert text in front of the column.

It is worth noting that if you use the `$` command to extend your selection to the end of the current line, the column will extend to the end of all selected lines, regardless of their length. The shift-A command will now append at the end of each of the selected lines. 

If you press the `r` key whilst in visual mode, it will replace every selected character with the next key that you press. To demonstrate this, I'm going to draw a box by filling my selection with hash characters, then filling an inner selection with spaces.

If you want to delete a column selection, you can do so with the `d` key. Note that if you use the dot command, it will repeat the operation on the same number of lines and columns. In a similar fashion, if you use the `p` key, it will paste the last column that was deleted or yanked.

Refining your selection
-----------------------

When you are in visual block mode, motion commands will alter the size of your rectangular selection by moving one corner. If you want to refine your selection by moving the opposite corner, you can do so by pressing the `o` key. Each time you press this, it toggles the cursor position between opposing corners.
