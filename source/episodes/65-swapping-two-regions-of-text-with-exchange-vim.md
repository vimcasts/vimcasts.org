--- 
:title: Swapping two regions of text with exchange.vim
:date: 2014/02/24
:poster: /images/posters/exchange.png
:flattr_id: ""
:duration: 245
:number: 65
:subtitle: Learn how the exchange.vim plugin makes it easy to swap two regions of text.
:tags: plugins, exchange, visual-mode
---

Swapping two regions of text is a common task, which normally requires that we make two separate changes to the document.
Tom McDonald's [exchange plugin][exchange] offers an elegant alternative, by providing an operator that swaps two regions of text in one go.

[exchange]: https://github.com/tommcdo/vim-exchange


READMORE

In [episode 54](/e/54), I covered a technique for swapping two regions of text using the [Visual mode put command][v_p]. It's a neat workflow, but there's room for some improvement.
This technique requires that we make two changes to the document, and consequently we have to press undo twice if we want to revert the swap.

For an alternative approach, check out [exchange][], by Tom McDonald. This is a little gem of a plugin! It provides one extra operation, which is mapped to `cx` by default.

    Used in pairs.
    FIRST USE: define the first region of text to be
    exchanged. Any valid {motion} can be used.
    SECOND USE: define the second region of text and
    perform the exchange.

One pleasing consequence to this approach is that we can revert the change by pressing undo one time.

### On the default mappings

I like the default mappings for exchange.vim. I think of it as a back-to-front mnemonic for *Ex-Change*, and that seems appropriate considering what the mapping does!

In the video, I began by demonstrating `{Visual}cx`, then went on to demonstrate the `cx{motion}` operator. There were some [problems with using `cx` as a Visual mode mapping][14]. These have now been resolved by [using X as the Visual mode mapping][20].

Previously, I recommended setting this up by putting this in your vimrc:

```viml
let g:exchange_no_mappings=1
nmap cx <Plug>(Exchange)
vmap X <Plug>(Exchange)
nmap cxc <Plug>(ExchangeClear)
nmap cxx <Plug>(ExchangeLine)
```

This snippet of Vimscript is no longer necessary - you can get this behaviour by installing the latest version of [exchange.vim][exchange].

### Further reading

* [exchange.vim][exchange] by Tom McDonald
* [`:h v_p`][v_p]
* [`:h v_c`][v_c]

[exchange]: https://github.com/tommcdo/vim-exchange
[v_c]: http://vimdoc.sourceforge.net/htmldoc/change.html#v_c
[v_p]: http://vimdoc.sourceforge.net/htmldoc/change.html#v_p
[14]: https://github.com/tommcdo/vim-exchange/issues/14
[20]: https://github.com/tommcdo/vim-exchange/pull/20
