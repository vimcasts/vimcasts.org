In most modern editing environments, the cursor does not need to be visible at all times. Here you can see that the cursor is blinking on the first line of the file. By scrolling the window, I can move the cursor out of sight. There's no problem with this. If I start typing, the window just scrolls until the cursor is visible again. 

By contrast, Vim's concept of a cursor does not allow for it to be out of site. Here, I have the cursor blinkning on the first line of the file. When I scroll the window down, the cursor comes with me. At first sight, this may seem like a terrible limitation, but Vim provides a couple of features which mean that in practice it rarely matters.

I'm going to use a simple editing task to demonstrate. Here, I am adding a rule to a stylesheet. I need to add a background-colour, but I've forgotten the hex value, so I scroll up to the top of the file and there it is: #e5e5e5. In TextMate, I know that my cursor is where I left it, so I just start typing and the text is entered in the appropriate place. 

Now lets do the same thing in Vim. I start by adding the rule, but as I get to the colour, I realise that I have to check against another part of the file. I leave insert mode, by hitting escape, then jump to the top of the file with the `gg` command. I make a mental note of the HEX value, then I need to get back into insert mode in the position where I last used it. The command `g;` 'G-semicolon' moves my cursor there, and then I can go back into insert mode by pressing the `a` key.

The Changelist
==============

Vim maintains a changelist, remembering the position of every change that can be undone. You can move through the changelist backwards using the `g;` 'G-semicolon' command. This is a bit like hitting undo multiple times, but instead of undoing each edit, it just moves the cursor to the place where an edit was made. You can also move forward through the changelist using the 'g,' 'G-comma' command.

You can view the positions saved in the changelist by issueing the command `:changes`.

The Jumplist
============

Vim also maintains a jumplist, remembering each position to which the cursor jumped, rather than scrolled. Some of the commands that are regarded as "jumps" include

* search commands and their repetitions.
* the substitution command.
* jumping between parentheses.
* jumping through paragraphs
* or sentences.
* moving to a specified line
* or a position within the current window.
* opening another file in the current window

You can move backwards and forwards through the jumplist with the commands 'control-O' and 'control-I'. The "control-O" command is a bit like the back button on a web browser, whereas 'control-I' is like the forward button. You can view the history by issuing the command `:jumps`.

The jumplist is useful when navigating Vim's documentation. The help system implements it's own version of a hyperlink, so you can jump between keywords by clicking them with the mouse, or moving the cursor to the link and pressing ctrl-] 'control-close-square-bracket'. You can then move back through the tags that you visited with ctrl-O.


Search and substitute
=====================
* /pattern
* ?pattern
* n
* N
* :s/pattern/replacement

Jump through parenthesis, paragraphs and sentences
==================================================
* %
* {
* }
* (
* )

Move the cursor within the screen
=================================
* L
* M
* H

Move the cursor within the file
===============================
* G, gg, [count]G


Open a new file
The commands that start editing a new file
==========================================

* :e
* :

If you make the cursor "jump" with one of these commands, the position of the cursor before the jump is remembered.  You can return to that position with the "''" and "``" command, unless the line containing that position was changed or deleted.

WHAT IS THE DIFFERENCE BETWEEN ctrl-O/ctrl-I and ''/``?

'' and `` are like ctlr-^, in that they toggle between one position and another. 

