INTRO
=====

If you have come to Vim from a more graphical editing environment, you may be used to using a visual explorer to navigate the file system. There are a couple of plugins for Vim which offer similar functionality: the NERD_tree is a popular choice, but in this episode I am going to focus on the netrw plugin. This is usually distributed with Vim, so you shouldn't have to install anything. For this reason, I tend to refer to it as Vim's 'native' file explorer.

EXPLORING THE FILE SYSTEM
=========================

If you launch vim with the path to a directory, then it will open with a file explorer. You'll also see this view if you issue the `:edit` command with the path to a directory. 

You can bring up the file explorer for the current working directory by issueing the command:

    :edit .

Or the lazy version: `:e.` - you don't even need the space!

The file explorer works just like any Vim buffer. So you can move up and down with the `k` and `j` keys. You can quickly jump to the bottom of the listing with `G` 'shift-G'. Or if it is a long listing and the file you want is somewhere in the middle, the quickest way to reach it is often to search for the filename. Hit `/` followed by the first few characters of the filename then enter. If you don't get an immediate match, the `n` key will take you to the next hit.

Traversing directories
----------------------

If you position the cursor on a directory and hit the return key, it will jump into that directory. Whenever the file explorer opens a new directory, the cursor is automatically positioned on the `..` item. Pressing return with the cursor here opens the parent directory. This makes it easy to climb back up the directory tree. Note that you can always move up a directory level, regardless of where the cursor is positioned, by pressing the `-` 'minus' key.

Using the return key on directories and the `..` item allows you to quickly traverse the file system.

Opening files
-------------

If you position the cursor on a file and hit the return key, it will open that file in the current window. As a result, the file explorer is removed from the window.

:Explore, :Sex and :Vex
-----------------------

As I mentioned earlier, you can always open a file explorer from the project root with the command:

    :edit .
    :e.

Another useful command is:

    :Explore    " explore with a capital E
    :E          " or simply, colon-big-e

This opens the file explorer using the directory of the last file that was opened in the current window.

There are split window variants for each of these commands. 

    :split .
    :sp.

will split the current window horizontally, and open a file explorer using the current working directory. Or you can split the window vertically with the command:

    :vsplit .
    :vsp.

If you would prefer to use the working directory of the file that you are currently editing, you can instead use:

    :Sex        " sexplore with a capital S
    :Vex        " vexplore with a capital V


MANIPULATING THE FILESYSTEM
===========================

Creating new files & directories
--------------------------------

One of the features that you might expect from a file explorer is the ability to create new files and directories. 

With a file explorer window open, you can create a new file in the currently selected directory by pressing the key

    %

This opens a prompt. Type the name of the file, and hit enter. This will open a new buffer, whose path corresponds to the filename you just specified. If you look at the filesystem, you can see that no file has actually been created yet, but as soon as I write the contents of the buffer with the `:w` command, the new file appears on the filesystem.

You can create a new directory from the file explorer by pressing the key:

    d

Again, this opens a prompt. Type the name of the directory, and hit enter. You can see that the new directory appears immediately in the file system. 

If you start to create a file or a directory, then change your mind and decide you don't want to after all, you can press the escape key to dismiss the prompt.

Renaming files & directories
----------------------------

Another task that you might expect from a file explorer is the ability to rename existing files and directories. As the 'Quick help' menu reveals, you can do so with the 'shift-R' command. This brings up a prompt saying:

> Moving path/of/old to : /path/of/new

You can delete the last portion of the path, then type the new name in its place hitting return to confirm, or escape to dismiss the prompt with no changes.

<!--Moving files & directories-->
<!------------------------------>

<!--In a graphical environment it might be possible to drag a file or folder from one location to another. There is no way of doing this with the mouse using Vim's file explorer. However, the `rename` command can be used to move a file or directory. -->

<!--Lets say I wanted to move `/current/path` to `/new/path`. I would open the file explorer, and position the cursor on `/current/path`. Pressing the 'R' key brings up a prompt saying:-->

<!--> Moving /current/path to : /new/path-->

<!--I move the cursor back using the arrow keys, then delete 'current' replacing it with 'new'. Hitting enter executes the move.-->

Deleting files & directories
----------------------------

You can also delete files from the file explorer, by pressing the key:

    D       " shift-D

This brings up a prompt. Enter 'y' then return to confirm that you want to delete the file. 

You can also use this command to delete directories, but only if they are empty.

POSTSCRIPT
==========

Please note that if you have installed the NERD_tree plugin, then for the most part it will replace Vim's native file explorer, and you won't be able to use the commands demonstrated in this video.
