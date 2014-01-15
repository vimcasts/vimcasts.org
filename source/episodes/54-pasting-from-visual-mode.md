--- 
:title: Pasting from Visual mode
:date: 2013/10/07
:poster: /images/posters/paste-from-visual.png
:flattr_id: ""
:duration: 213
:number: 54
:ogg: 
  :url: http://media.vimcasts.org/videos/54/visual-mode-put.ogv
  :size: 3955140
:quicktime: 
  :url: http://media.vimcasts.org/videos/54/visual-mode-put.m4v
  :size: 6773573

---

When used [in Visual mode the `p` command][v_p] replaces the selection with the contents of a register. This makes for a smooth workflow when you want to overwrite a selection, or swap the order of two regions of text.

[v_p]: http://vimdoc.sourceforge.net/htmldoc/change.html#v_p


READMORE

<r:snippet name="announcement"/>

From Vim's documentation (see [`:help v_p`][v_p]):

> When using a put command like `p` or `P` in Visual mode, Vim will try to replace the selected text with the contents of the register.

This command has a side-effect: the text that was originally selected is copied to the default register. In effect, this means that the text in the default register and the text that's selected in the document swap places.

### replace{motion} commands

In general, I encourage staying out of visual mode where possible. For example, instead of visually selecting a word then deleting it (`viwd`), I prefer to use the `d{motion}` operation (`diw`). But Vim has no built-in Normal mode operation that emulates the behaviour of put in Visual mode, so this is one place where I encourage using Visual mode.

If you'd like to make this operation without using Visual mode, there are several plugins that add this behavior.
Kana Natsuno's [operator-replace][] plugin doesn't provide a mapping by default, but in the documentation the author suggests binding the operation to `_{motion}`. Ingo Karkat's [ReplaceWithRegister][] plugin creates a `gr{motion}` mapping. Steve Vermeulen's [easyclip][] plugin provides a [substitution operator][sub].

If I've missed any plugins that provide this functionality, please leave a comment below.

### Further reading

* [`:h v_p`][v_p]
* [`:h quote0`][quote0]
* [`:h quotequote`](http://vimdoc.sourceforge.net/htmldoc/change.html#quotequote)
* [Practical Vim][pv], tip 61: Replace a visual selection with a register

[v_p]: http://vimdoc.sourceforge.net/htmldoc/change.html#v_p
[pv]: http://pragprog.com/book/dnvim/practical-vim
[quote0]: http://vimdoc.sourceforge.net/htmldoc/change.html#quote0

[operator-replace]: https://github.com/kana/vim-operator-replace
[ReplaceWithRegister]: https://github.com/vim-scripts/ReplaceWithRegister
[easyclip]: https://github.com/svermeulen/vim-easyclip
[sub]: https://github.com/svermeulen/vim-easyclip#substitution-operator
