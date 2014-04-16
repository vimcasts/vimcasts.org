If you want to edit a file in a new tab, you can do so by editing the `:tabedit` command followed by the name of the file that you want to edit. This opens a new tab containing the file that you specified.

Suppose that you are working with multiple split windows within a single tab, and you decide that, actually, I would rather work on file c in a tab of its own. You can move the currently active window into a tab of its own by issuing the command "control-double-you, shift-tee". If we go back to the previous tab you can see that it's no longer split, and the window containing file C has moved into a tab of its own.

If the current tab just contains a single window, then you can close the window and the tab with it by executing the `:q` command. However, if the currently active tab contains multiple split windows, then the `:q` command would merely close the currently active window. If you want to close the current tab and all of its windows, you can do so using the `:tabclose` command.

If you have multiple tabs open and you wish to close lots of them rapidly you can do so by issuing the `:tabonly` command. This will close all tabs apart from the current one.

## Switching tabs

There are several ways of navigating between tabs. Using the mouse, you can click directly on a tab to activate it. There are also key-commands, such as `gt`, which will advance through the tabs. And if you are on the final tab it will go back to the beginning. Or you can do "G-shift-tee", which will go through the tabs backwards.

If you prepend a number to the `gt` command, it will jump directly to the specified tab. So if I say `4gt`, it'll go to the fourth tab. `3gt` goes to the third tab, and so on.

I am accustomed to the tab navigation commands for Firefox, and I would like to port them over to my Vim environment. To do so, I include the following in my vimrc file. I can now move to neighbouring tabs with command-shift-square-bracket keys. Or I can jump straight to the second tab with command two, and so on up to nine tabs. Regardless of how many tabs are open, I can always jump to the last one with command-zero.

These mappings use the command key on the mac. For linux and windows users, replace "D" with "C" to use the control key instead.

## Reordering tabs

Here I am using MacVim, which lets me drag and drop tabs to reorder them with the mouse. This won't work if you run Vim in the terminal, but there is a command that you can use to rearrange tabs. Without any arguments, `:tabmove` puts the current tab at the end. `:tabmove 0` puts the current tab to the beginning. And `:tabmove 1` places the current tab *after* tabpage number 1, that is, it moves the tab to position 2.

