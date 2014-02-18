--- 
:title: Accessing the system clipboard from Vim
:date: 2013/11/11
:poster: /images/posters/clipboard-register.png
:flattr_id: ""
:duration: 288
:number: 58
:ogg: 
  :url: http://media.vimcasts.org/videos/58/clipboard-register.ogv
  :size: 6577643
:quicktime: 
  :url: http://media.vimcasts.org/videos/58/clipboard-register.m4v
  :size: 12031236
:tags: registers, copy-and-paste
:layout: episode
---

In some environments, Vim lets us access the system clipboard using the quoteplus register, `"+`. When this feature is enabled, we can use it with the delete, yank and put operations in much the same way that we use Vim's other registers. Pasting from this register usually produces better results than using the system paste command in Insert mode.


READMORE


This is an abridged quote from Vim's documentation (see [`:h quoteplus`][quoteplus]):

> CLIPBOARD is expected to be used for cut, copy and paste operations.
> ...
> Vim uses CLIPBOARD when reading and writing the "+ register.  

So long as your version of Vim has been compiled with support for the `+clipboard` feature, then you can use the `"+` register to access your system clipboard.

### Using the quoteplus register

The `"+` register can be used much like any other register. For example, if you want to yank text from a Vim buffer into the system clipboard, you could use any of these commands:

<table>
<tr>
<th>command</th>
<th>effect</th>
</tr>
<tr>
<td><code>{Visual}"+y</code></td>
<td>copy the selected text into the system clipboard</td>
</tr>
<tr>
<td><code>"+y{motion}</code></td>
<td>copy the text specified by <code>{motion}</code> into the system clipboard</td>
</tr>
<tr>
<td><code>:[range]yank&nbsp;+</code></td>
<td>copy the text specified by <code>[range]</code> into the system clipboard</td>
</tr>
</table>

If you want to paste text from the system clipboard into your Vim buffer, you could use any of these commands:

<table>
<tr>
<th>command</th>
<th>effect</th>
</tr>
<tr>
<td><code>"+p</code></td>
<td>Normal mode put command pastes system clipboard after cursor</td>
</tr>
<tr>
<td><code>:put +</code></td>
<td>Ex command puts contents of system clipboard on a new line</td>
</tr>
<tr>
<td><code>&lt;C-r&gt;+</code></td>
<td>From insert mode (or commandline mode)</td>
</tr>
</table>


### The `"+p` command produces better results than `ctrl-v`

Using `ctrl-v` in Insert mode can produce strange artefacts, and for large sections of text it's also noticably slower than pasting from the quoteplus register.

If your clipboard contains a multi-line range of text, then the `ctrl-v` command can produce strange results in Insert mode. Vim receives a stream of characters and interprets them just as though they were typed manually. If the autoindent feature is enabled, the Vim automatically adds spaces at the start of each line. When combined with the indentation already present in the code snippet, the result is that each line drifts farther and farther to the right. By contrast, if you use paste from the quoteplus register (e.g. using `"+p` or `:put +`), you can avoid this problem.

For large sections of text, the quoteplus register is noticably quicker than using `ctrl-v` in Insert mode. As an experiment, try this: copy the [entire text of War and Peace][tolstoy] into your clipboard. Open a new instance of Vim, switch to insert mode, and press `ctrl-v` (or `cmd-v` if you're on a mac). Vim receives a stream of characters and inserts them into the document one by one. You might have to wait a while until you get control back! Now open another instance of Vim and run the command `:put +`. This time, the entire text should appear in your buffer instantly.

If you're running GVim (or MacVim), then you shouldn't experience any problems with the `ctrl-v` command. In the graphical environment, Vim can detect when a stream of input comes from the clipboard, and adjust its behavior accordingly. But when Vim runs inside the terminal, there's no way it can tell whether the text is being entered manually or pasted from the clipboard.

### What's the difference between `'clipboard'` and `'xterm_clipboard'` features?

The `+clipboard` feature gives us access to the system clipboard through the `"+` register. By "system clipboard", I mean the one that we usually access with the system-wide cut, copy, and paste operations.

When Vim runs inside of [xterm][], the `'+xterm_clipboard'` feature gives us access to [the *primary* selection][primary] through the `"*` register. This feature permits the following workflow: visually select text in Vim, switch to another app and use the middle mouse button to paste the text you selected. I've never used this workflow and I don't find it appealing. One reason I use Vim is because I want to avoid using the mouse!

If your Vim was compiled with `+clipboard` and `-xterm_clipboard` (as my Vim is), then you can use `"+` and `"*` interchangeably; both will access the system clipboard.

### Make Vim use the system clipboard as the default register

If you'd like to make it easier to interact with the system clipboard, try out this setting:

    :set clipboard=unnamed

That tells Vim to use the [quotestar register][quotestar] for all yank, delete, change, and put operations that have no register explicitly specified. In effect, the system clipboard becomes the default register. Beware that with this setting, the `x` command will write a single character to the system clipboard, overwriting whatever was in there previously.

If your version of Vim supports both the `+clipboard` and `+xterm_clipboard` features, then you might prefer to use this setting instead:

    :set clipboard=unnamed,unnamedplus

Read `:h clipboard-unnamedplus` for more details.

### Further reading

* [`:help quoteplus`][quoteplus]
* [`:help quotestar`][quotestar]
* [`:help 'clipboard'`]['clipboard']
* [Alfred's Clipboard history feature][alfred]

[quoteplus]: http://vimdoc.sourceforge.net/htmldoc/gui_x11.html#quoteplus
[quotestar]: http://vimdoc.sourceforge.net/htmldoc/gui.html#quotestar
['clipboard']: http://vimdoc.sourceforge.net/htmldoc/options.html#'clipboard'
[alfred]: http://support.alfredapp.com/features:clipboard
[unnamed]: http://vimdoc.sourceforge.net/htmldoc/options.html#clipboard-unnamed
[tolstoy]: http://www.gutenberg.org/cache/epub/2600/pg2600.txt
[gist]: http://fizzbuzz.org/UPDATE_THIS_URL!
[xterm]: http://invisible-island.net/xterm/
[primary]: https://wiki.archlinux.org/index.php/Xterm#Copy_and_paste
