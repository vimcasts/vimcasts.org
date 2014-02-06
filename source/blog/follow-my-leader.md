--- 
:title: Follow my leader
:date: 2014/02/05

---

Choosing a key-map for your custom Vim commands can be difficult. The common advice is to use `<leader>` for user-defined mappings, but that's not the only option. There are dozens of two-key mappings that are not bound to any built-in functionality. These available mappings are easy to find if you follow a simple formula.


READMORE

### Vim's key-map space appears to be saturated

In Vim's Normal mode, every key (with and without shift) is mapped to some built-in functionality. This is visualized clearly by Jon Beltran de Heredia's [graphical Vim cheat sheet][cheat].

<a href="http://www.viemu.com/vi-vim-cheat-sheet.gif"><img src="http://www.viemu.com/vi-vim-cheat-sheet.gif" alt="Vim graphical cheat sheet" width=640/></a>

At the same time Vim is highly customizable, which presents a small paradox: if the user adds some custom functionality, how are they supposed to create a key mapping for it if all of the keys are already in use?

Vim's documentation provides a few suggestions at [`:h map-which-keys`][map-which-keys]. The most common practice is to use the `<leader>` key, which you can think of as being a namespace reserved for user-defined functionality. Steve Losh has a good [introduction to Vim's leader][leader] in Learn Vimscript the Hard Way.

### Leader maps are lame

I used leader maps unquestioningly for years. Then one day I read a github issue in which Tim Pope suggests [adding default mappings to splitjoin.vim][lame]. In it, he says:

> leader maps are pretty lame

That got me scratching my head. I couldn't think of a single Tim Pope plugin that used a `<leader>` mapping. How does he do it?

Looking closer, I noticed a few patterns in Tim Pope's choice of mappings. Once I'd noticed the pattern, it became clear that Vim's key-map space is not nearly as saturated as I had previously believed. 

### Valid operations

The [graphical cheat sheet][cheat-image] color-codes commands into a few categories: orange for operators, green for motions, and yellow for just about everything else. I'll borrow that convention for this discussion.

The operator commands (in orange) can be used in two forms: `{operator}{operator}` will execute the operation on the current line, while `{operator}{motion}` executes the operation over the range specified by the motion. (In this context, consider `{motion}` to be a shorthand for "motion or text object".) This table summarises:

<table>
    <tr>
        <th>strokes</th>
        <th>explanation</th>
    </tr>
    <tr>
        <td>
            <div class="cheatkey operator">operator</div>
            <div class="cheatkey operator">operator</div>
        </td>
        <td>peform linewise operation</td>
    </tr>
    <tr>
        <td>
            <div class="cheatkey operator">operator</div>
            <div class="cheatkey motion">motion</div>
        </td>
        <td>peform operation on range specified by motion</td>
    </tr>
</table>

There's something beautiful about these rules, which define [Vim's grammar][grammar] for composing operations.
Vim allows you to define custom operators and motions (as well as text objects).
I love the fact that user-defined operators and motions plug right in to Vim's grammar, just as though we were extending our vocabulary with new verbs and nouns. Read my essay on [sharpening the saw][saw] for a few concrete examples

### Invalid operations

We can describe all valid operations in simple terms: an orange key must be followed directly either by the same orange key, or by any green key. That means there are dozens of two-key combinations starting with an operator (orange key) which don't produce a valid operation. For example, an operator followed by a non-motion (yellow key) does not perform an operation. An operator followed by *a different operator* also aborts the operation. From these blind-spots in Vim's grammar, we can create a general formula for finding vacant keymaps:

<table>
    <tr>
        <th>strokes</th>
        <th>explanation</th>
    </tr>
    <tr>
        <td>
            <div class="cheatkey operator">operator</div>
            <div class="cheatkey non-motion">non-motion</div>
        </td>
        <td>Invalid operation</td>
    </tr>
    <tr>
        <td>
            <div class="cheatkey operator">operator-1</div>
            <div class="cheatkey operator-2">operator-2</div>
        </td>
        <td>Invalid operation</td>
    </tr>
</table>

I can't think of any examples of mappings that combine two different operators. Perhaps there's a good reason not to create mappings such as `dc` and `cd`. If you can think of one, please let me know in the comments.

Out of the box, Vim has a couple of commands that follow the `{operator}{non-motion}` pattern. For example, the [`dp`][dp] and [`do`][do] commands are Normal mode shorthands for `:diffput` and `:diffget`.
I've noticed that a lot of plugins (especially those by [@tpope][]) mine this space for available mappings.

For example in [surround.vim][], we can use the `cs` mapping to change one surrounding pair of symbols for another (mnemonic: "change surrounding"). We can delete a pair of symbols with the `ds` mapping (mnemonic: "delete surrounding"). And we can use the `ys{motion}` mapping to add a pair of surrounding symbols to the range specified by the motion (mnemonic: "you surround"). 

In Tim Pope's [unimpaired.vim][], the `co` mapping is used a prefix for toggling various settings on and off (mnemonic: "change option"). For example, `cow` toggles the `'wrap'` option, `con` toggles `'number'`, `cos` toggles the spell-checker. I used to use `<leader>w` to toggle `'wrap'`, and `<leader>s` to toggle `'spell'`, but I much prefer the mappings provided by unimpaired.vim. And whats more, it frees up those leader mappings for something more useful.

In [abolish.vim][], the `cr` mapping allows us to coerce text between `MixedCase`, `snake_case`, and so on (mnemonic: "CoeRce"). In [exchange][], by Tom McDonald, the `cx` mapping allows us to swap two regions of text (mnemonic: "eX-Change" - but it's back to front!).

### Leader maps are ok

If you are adding custom commands to your vimrc, there's no reason to avoid creating a leader mapping for them. But if you're creating a plugin that modifies the text in your buffer, you can do better. Use the formula above to find a vacant mapping. If you can devise a mnemonic that explains why your two-key mapping triggers your command, your users will thank you.

I gave a presentation on this topic at Vim London last week: [Follow my leader][coverage]. My slides are published [on speakerdeck][vimlondon-slides] and you can watch a video of the talk [on Vimeo][vimlondon-video].


[losh-on-leader]: http://stevelosh.com/blog/2010/09/coming-home-to-vim/#using-the-leader
[leader]: http://learnvimscriptthehardway.stevelosh.com/chapters/06.html
[cheat]: http://www.viemu.com/a_vi_vim_graphical_cheat_sheet_tutorial.html
[cheat-image]: http://www.viemu.com/vi-vim-cheat-sheet.gif
[saw]: http://vimcasts.org/blog/2012/08/on-sharpening-the-saw/
[grammar]: http://glts.github.io/2013/04/28/vim-normal-mode-grammar.html
[dp]: http://vimdoc.sourceforge.net/htmldoc/diff.html#dp
[do]: http://vimdoc.sourceforge.net/htmldoc/diff.html#do
[@tpope]: https://github.com/tpope
[surround.vim]: https://github.com/tpope/vim-surround
[unimpaired.vim]: https://github.com/tpope/vim-unimpaired
[abolish.vim]: https://github.com/tpope/vim-abolish
[exchange]: https://github.com/tommcdo/vim-exchange
[map-which-keys]: http://vimdoc.sourceforge.net/htmldoc/map.html#map-which-keys
[lame]: https://github.com/AndrewRadev/splitjoin.vim/issues/14
[vimlondon-slides]: https://speakerdeck.com/nelstrom/follow-my-leader
[vimlondon-video]: https://vimeo.com/85343734
[coverage]: http://lanyrd.com/2014/vimlondon/scwggw/
