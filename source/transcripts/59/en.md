In the previous episode, we saw how to use the quoteplus register to paste text from the system clipboard. Unfortunately, we can't always expect the clipboard feature to be supported. In particular, if we're running an instance of Vim on a remote machine, there's no simple way of accessing the clipboard from our local workstation.

We can use the system paste command: control-v, or command-v on a mac, but this has some issues. Watch what happens if I copy this snippet of javascript, then use the system paste command in Insert mode: the indentation goes haywire!

The problem is that when Vim runs inside a terminal, it can't distinguish between characters that are typed manually and those that are pasted. In this case, each time Vim creates a newline, it's autoindented. Add on top of that the indentation that was already present the source code, and we end up with each line drifting farther and farther to the right.

We can avoid this by enabling the `paste` option, which temporarily disables several options that can interfere when pasting text. Watch:

    :set paste

I'll switch to Insert mode. Note that Vim tells us the paste option is enabled. Now when I use the system paste command it behaves fine!

You might be wondering: Why not keep the `paste` option enabled at all times? Well, there's a gotcha! When the paste option is enabled, any abbreviations or mappings defined for Insert mode will be disabled. To demonstrate, I'll map `kj` to Escape in Insert mode:

    :inoremap kj <Esc>

If I try using that mapping in Insert mode, it just inserts the characters `kj`. But if I disable the `paste` option:

    :set nopaste

and switch back to Insert mode, pressing `kj` now maps to the Escape key, putting me back into Normal mode.

So remember: with the `paste` option enabled, you're safe to use the system paste command, but any user-defined Insert mode mappings will fail. For that reason, it's a good idea to turn off the `paste` option as soon as you're finished using it.

If you're thinking of creating a mapping to make it easier to toggle the paste option, don't forget that your mapping won't work in Insert mode! Read Vim's documentation on `'pastetoggle'` to learn about a workaround.

### Unimpaired mapping

I like the solution Tim Pope has come up with in his unimpaired plugin. He notes that:

> you toggle twice, but only paste once.
> :h yp

Which is wasteful.

Watch this:

    :set paste?
    nopaste

The paste option is currently disabled. I'll switch to Insert mode by pressing `yo`, which is a mapping provided by unimpaired. Just like the regular `o` command, it opens a new line and switches to Insert mode, but this variant also enables the `paste` option. I can safely use the system paste command. And when I return to Normal mode, an autocommand disables the paste option for me:

    :set paste?
    nopaste

That's a much neater workflow than having to toggle the `paste` option on and off again manually.
