In Neovim, we can launch a terminal emulator by running the `:terminal` command.
Now we're running a shell inside of our text editor.
We can run commands in the shell as usual.

    > pwd
    > ls
    > cat abstract.md
    > exit

When we exit the shell, the terminal emulator closes and Neovim switches us back to a regular buffer.

Let's fire up another terminal emulator:

    :terminal

Notice that at the bottom of the screen it shows that we're in `TERMINAL` mode.
As long as we're in this mode, all keys and chords that we press are sent to the terminal emulator.
There's one single exception: if we press *control-backslash* then *control-N*, we'll switch back to Normal mode.

## Interacting with a Terminal buffer in Normal mode

In Normal mode, we can move the cursor using all the usual motions. (demo h, j, k, l, w, b)
We can scroll the terminal buffer up and down a line at a time using *control-e* and *control-y*.
We can switch to Visual mode and make a selection.
And we can use the `y` command to copy text into a register.

    :reg "

But if we attempt to use any commands that would modify the text in the buffer, Neovim shows us an error message:

> E21: Cannot make changes, 'modifiable' is off

In effect, all of the text in a terminal buffer is readonly, apart from the current command line which may be edited while in Terminal mode.

## Switching between Normal and Terminal modes

Any time we want to switch back into Terminal mode, we can do so by pressing the `i` key.
In a regular text buffer, we can use *shift-A* to insert at the end of a line, or *shift-I* to insert at the start of a line.
Using these keys in a terminal buffer will switch to Terminal mode, but the cursor always resumes from where we left off.

When I first started to use Neovim's terminal emulator, I found myself trying to use the escape key to exit Terminal mode.
That doesn't work!
When we use the escape key in Terminal mode, Neovim forwards it to the shell.
Remember: in Terminal mode, Neovim *forwards all keys* to the underlying program, the only exception being: *control-backslash-control-N*, which is how we get back to Normal mode.
In another video, we'll look at how we can create a mapping to make the escape key exit Terminal mode.

## Split windows and hidden terminal buffers

The `gf` command works fine in terminal buffers, so if we run a command that outputs filepaths:

    ls -d1 ~/.config/nvim/*
    /Users/demo/.config/nvim/init.vim
    /Users/demo/.config/nvim/pack

We can switch to Normal mode, move our cursor to a filepath, then quickly open the file under the cursor by pressing `gf`.
Our terminal buffer is now the alternate file for this window:

    :ls
      1 #h-  "term://.//98835:/bin/bash"    line 2
      2 %a   "~/.config/nvim/init.vim"      line 1

So we can quickly switch back again by pressing *control-caret*.

Let's open another file in a split window:

    :split abstract.md

We can switch the focus between these splits using the usual window switching commands.

I'm just going to launch an installer, as an example of a long-running process.

    gem install rails

We can close the window containing the terminal buffer.

Any processes that are running the terminal will continue to run even while the buffer is not visible.
If we list the buffers:

    :ls

The terminal buffer shows up in the list.

We can easily switch back to it again with the `:b bash` command:

    :b bash

And we're just in time to see the installer process completing.

Let's just quickly set up a rails app for demonstration purposes...
Then we'll switch to the directory of the new app.

### Multiple terminals

When we run the `:terminal` command, we can also supply a command as an argument, and the specified program will be spawned in the new terminal emulator.
Here, I'll launch a rails server in one terminal, and a `top` process in another.

    :terminal rails server
    :terminal top

These terminal buffers will also show up in our buffer listing.

    :ls

We can run as many terminal emulators as we like inside of Neovim.

There are a few ways that we can shut down our terminal emulators.
If we take note of the buffer number, we can pass it as an argument to the *bdelete-bang* command 

   :bdelete! 6

Or we could activate the terminal buffer, switch to Terminal mode, then kill the process in the usual manner.

Finally, when we quit Neovim, any remaining terminal buffers will be killed.
As you can see my rails server is currently running.

[visit localhost:3000 - see rails welcome page]

But after I quit Neovim, the server is down.

[refresh localhost:3000 - see nothing]

Here's one final tip: we can start Neovim in Terminal mode by running:

    nvim +terminal

I frequently use this when opening a project where I need to spin up a server or something before I can start work.
