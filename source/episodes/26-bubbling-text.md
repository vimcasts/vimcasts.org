--- 
:title: Bubbling text
:date: 2010/10/05
:poster: /images/posters/bubbling_text.png
:flattr_id: "69651"
:duration: 383
:number: 26
:tags: customization, editing-text
---

TextMate has a few built in commands for moving selected text around a document. The end end result of using these commands can be achieved by cutting and pasting, but the visual feedback they provide is quite helpful. In this episode, I will show how to replicate these commands in Vim.

READMORE


In TextMate, the commands for moving selected text can be found under the "Text > Move Selection" menu. I find "move selected line up" to be an acurate but dull description. Personally, I prefer to call this feature *text bubbling*. 

![TextMate's Move selection commands](/images/blog/bubble-text.png)

In the video, I describe two different ways of reproducing the text bubbling feature.

## Text bubble with Vim primitives

By putting the following in your `.vimrc` file, you can create maps for bubbling text up and down:

```viml
" Bubble single lines
nmap <C-Up> ddkP
nmap <C-Down> ddp
" Bubble multiple lines
vmap <C-Up> xkP`[V`]
vmap <C-Down> xp`[V`]
```

### Edge cases

These mappings have a flaw which is only apparent when you use them at the boundaries of a document. For example, if the cursor is placed on the last line of a file and you try to move it up by one line, instead it moves up by two lines. Remember that these mappings are blind, they just replay a series of keystrokes, without any understanding of context.

## Text bubble with unimpaired.vim

A better solution is available if you install Tim Pope's [unimpaired][pair] plugin. This provides the *exchange* commands, which are mapped to `[e` and `]e` respectively:

    [e  -  Exchange the current line with [count] lines above it.
    ]e  -  Exchange the current line with [count] lines below it.

These commands can be prepended with a count, and they both also work in Visual mode. Whatsmore, they handle edgecases more gracefully, by raising an error message: **Invalid address**.

If you have the unimpaired plugin installed, then you can use the "square bracket e" commands to bubble text up and down. But if you are used to the TextMate key commands, you could always recreate those mappings and hook into the commands from unimpaired. This excerpt of Vimscript should do it:

```viml
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
```

## Visually select the last edited text

You may already know that [`gv`][reselect] can be used to start visual mode with the same selection as last time visual mode was used. If you have cut and pasted a visual selection, then this doesn't work the way that you would expect. Fortunately, you can visually select the text from the last edit by jumping to the first and last characters with the motions `\`[` and `\`]`.

I keep the following mapping in my `.vimrc`:

```viml
" Visually select the text that was last edited/pasted
nmap gV `[v`]
```

So with `gv` I can reselect the last visual selection, and with `gV` I can visually select the text that was most recently edited or pasted.

### Further reading

* <a href="http://vimdoc.sourceforge.net/htmldoc/visual.html#gv"><code>:help gv</code></a> - reselect last visual selection
* <a href="http://vimdoc.sourceforge.net/htmldoc/motion.html#'["><code>:help \`[</code></a> - go to first character of latest edit
* <a href="http://vimdoc.sourceforge.net/htmldoc/motion.html#']"><code>:help \`]</code></a> - go to last character of latest edit
* [unimpaired.vim][pair] - a plugin by Tim Pope ([source on github][pair_repo])

[pair]: http://www.vim.org/scripts/script.php?script_id=1590
[pair_repo]: http://github.com/tpope/vim-unimpaired
[edit_first]: http://vimdoc.sourceforge.net/htmldoc/motion.html#'[
[edit_last]: http://vimdoc.sourceforge.net/htmldoc/motion.html#']
[reselect]: http://vimdoc.sourceforge.net/htmldoc/visual.html#gv

