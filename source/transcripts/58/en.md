## Copying text to the system clipboard

[clear Alfred clipboard history]

I've set up a hotkey to display an inspector window that shows my clipboard history. [show Alfred clipboard history]

It's empty at the moment, but if I select the URL from my browser's location bar and copy it, you'll see that it shows up in my clipboard history. [show Alfred clipboard history]

Inside of Vim, I can copy text into the system clipboard by using the quoteplus register. Watch this: I'll visually select this snippet of code, then press `"+y` "quote-plus-wye". That snippet now shows up as the topmost item in my clipboard history. [show Alfred clipboard history]

Now that the text is in my clipboard, I can easily paste it into other applications running on my machine.

## Pasting from the system clipboard

Suppose that I want to copy some text from a webpage into a Vim buffer. I'll copy this short snippet of javascript from [this gist][fizzbuzz]. Here in Vim, I have an empty file called `fizzbuzz.js`. I'll switch to Insert mode and use the system paste command (command-v).

Whoops! That doesn't look right! Vim receives a stream of characters and interprets them just as though they were typed manually. Vim's autoindent feature adds indentation each time a new line is started. When combined with the indentation already present in the pasted source code, the result is that each line drifts farther and farther to the right.

By the way, if you're running GVim (or MacVim), then you won't experience this problem. In the graphical environment, Vim is able to detect when a stream of input comes from the clipboard, and adjusts its behavior accordingly.

In Terminal Vim, we can avoid this problem by pasting from the quoteplus register. I'll use the Ex put command this time:

    :put +

That's more like it!

If you're dealing with snippets of text less than a line in length, there's no reason to avoid using the system paste command in Insert mode. But if you're pasting multiple lines of text, I'd encourage you to use the quoteplus register where possible.

[fizzbuzz]: http://rosettacode.org/wiki/FizzBuzz#JavaScript

## Make quoteplus the default register

If you'd like to make it easier to interact with the system clipboard, try out this setting:

    :set clipboard=unnamed

That tells Vim to use the system clipboard for all yank, delete, change, and put operations that have no register explicitly specified. In effect, the system clipboard becomes the default register.

Now if I run `yy` to yank a line, that text appears in the system clipboard.

Beware that with this setting, Vim's `x` command will write a single character to the system clipboard, overwriting whatever was in there previously. That really irritates me, but being able to use a clipboard history browser makes it bareable.

## Feature support (good then bad)

For all the examples in this video so far, I've been using the version of Vim that I have installed locally on my workstation. This version was compiled with support for the clipboard feature:

    :version
    ... +clipboard ...

If I log into a remote machine and launch the version of Vim installed there, you'll see that it doesn't support the clipboard feature:

    :version
    ... -clipboard ...

If I attempt to paste from the plus register:

    :put +

Vim raises an error: *Invalid register name*. That's fine. I'm controlling a remote machine. It makes sense that I can't access the system clipboard from my workstation.

But if you get this error from your local version of Vim, then I'd encourage you to install a version of Vim with clipboard support, or compile it yourself! It's an essential feature.
