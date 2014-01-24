--- 
:title: Using Vim's named registers
:date: 2013/10/04
:tags: registers
:poster: /images/posters/named-registers.png
:flattr_id: ""
:duration: 209
:number: 53
:ogg: 
  :url: http://media.vimcasts.org/videos/53/named-registers.ogv
  :size: 5356368
:quicktime: 
  :url: http://media.vimcasts.org/videos/53/named-registers.m4v
  :size: 9269387

---

We've met Vim's [default register][quotequote] and the [yank register][quote0]. This time, we're going to look at the [named registers][quote_alpha], which are handy if you want to cut or copy some text that you intend to paste multiple times.

[quotequote]: http://vimdoc.sourceforge.net/htmldoc/change.html#quotequote
[quote0]: http://vimdoc.sourceforge.net/htmldoc/change.html#quote0
[quote_alpha]: http://vimdoc.sourceforge.net/htmldoc/change.html#quote_alpha


READMORE


From Vim's documentation (see [`:h quote_alpha`][quote_alpha]):

> Vim fills these registers only when you say so. Specify them as lowercase letters to replace their previous contents or as uppercase letters to append to their previous contents. 

Vim has 26 named registers: one for each letter of the alphabet

The named registers are handy for copy and paste, especially when you want to paste the same text multiple times. Use `"ay{motion}` to copy text to register 'a', then `"ap` to paste text from that register into the document.

Note that when we yank text into a named register, Vim writes that text to the default register and to the specified register, but it does not touch the yank register.

### Appending to a named register

Using an uppercase letter tells Vim to append text to the specified register (rather than overwriting the existing contents). For example, `"Ayy` copies the current line, and appends it to register 'a'.

I prefer using the Ex command `:yank A` over the normal mode command `"Ayy`. In both cases, it would be easy to accidentally type a lowercase letter, which would cause the specified register to be overwritten. But in the case of the Ex command, it's easier to see when you make a mistake, and easier to correct it.

### Collecting all lines that match a pattern in a register

We can clear the contents of named register 'a' by running the command: `qaq`. The `qa` command instructs Vim to start recording keystrokes into register 'a', then the final `q` stops the macro recording. No keystrokes were recorded, so the register ends up blank.

Now we can use this Ex command:

    :global/TODO/yank A

For each line that matches the pattern `TODO`, run the Ex command: `:yank A`.

### Further reading

* [`:h quote_alpha`][quote_alpha]
* [`:h :yank`](http://vimdoc.sourceforge.net/htmldoc/change.html#:yank)
* [`:h :global`](http://vimdoc.sourceforge.net/htmldoc/repeat.html#:global)
* [`:h :reg`](http://vimdoc.sourceforge.net/htmldoc/change.html#:reg)
* [Practical Vim][pv], Tip 60: Grok Vim's registers
* [Practical Vim][pv], Tip 99: Collect TODO items in a register

[quote_alpha]: http://vimdoc.sourceforge.net/htmldoc/change.html#quote_alpha
[pv]: http://pragprog.com/book/dnvim/practical-vim
