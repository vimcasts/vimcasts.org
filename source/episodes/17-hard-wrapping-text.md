--- 
:title: Hard wrapping text
:date: 2010/04/26
:poster: /images/posters/hard_wrapping_text.png
:flattr_id: "31942"
:duration: 323
:number: 17
:tags: plaintext, wrapping
---

It is sometimes preferable to format text with hard wrapped lines, for example when writing emails in plaintext. Vim can apply this style of formatting for you. This episode shows some of the options which allow you to customize Vim's text formatting.


READMORE


The `gq{motion}` command will format a section of text. The `ip` motion selects the current paragraph, so `gqip` applies formatting to the current paragraph.

Running the `gq` command moves the cursor to the end of the paragraph. If you want to keep the cursor on the same word, you can instead run the command `gw`.

The `textwidth` setting is a number representing the maximum allowed width of a line. When set to zero, which is the default, Vim will use the full width of the window up to a maximum of 80 characters. When set to a value above zero, Vim will format lines of text so as not to exceed the value of `textwidth`.

The `wrapmargin` setting can be used to specify the number of characters from the right window border where wrapping begins. This can be useful if you have `number` or `foldcolumn` enabled, as both of these use up some of the width of the window. The `textwidth` setting takes precedence over `wrapmargin`.

You can influence how Vim applies formatting with the `formatoptions` setting. This is a string, which may contain any of the flags defined in [`fo-table`][fo_table]. You can set the `formatoptions` to a string by direct assignment:

    :set formatoptions=tcq

You can also add and remove flags from the list, with the following invocations:

    :set fo+=a
    :set fo-=n

In the video, I demonstrate how Vim behaves when inserting, editing and deleting text with a blank `formatoptions` string, then with `fo=t`, and finally with `fo=ta`.

Note that the `gq` command will only invoke Vim's internal formatter if both the `formatexpr` and `formatprg` options are blank. On the other hand, the `gw` command will always invoke Vim's internal formatting engine, even if one of the alternate formatters is enabled.

###Further reading

* [`:help usr_25` - Editing formatted text][formatting]
* [`:help gq`][gq]
* [`:help gw`][gw]
* [`:help fo-table`][fo_table]
* [`:help add-option-flags`][opt_flags]
* [`:help auto-format`][auto-format]
* [`:help formatprg`][formatprg]
* [`:help formatexpr`][formatexpr]

[formatting]: http://vimdoc.sourceforge.net/htmldoc/usr_25.html
[gq]: http://vimdoc.sourceforge.net/htmldoc/change.html#gq 
[gw]: http://vimdoc.sourceforge.net/htmldoc/change.html#gw 
[auto-format]: http://vimdoc.sourceforge.net/htmldoc/change.html#auto-format
[fo_table]: http://vimdoc.sourceforge.net/htmldoc/change.html#fo-table
[opt_flags]: http://vimdoc.sourceforge.net/htmldoc/options.html#add-option-flags
[formatprg]: http://vimdoc.sourceforge.net/htmldoc/options.html#'formatprg'
[formatexpr]: http://vimdoc.sourceforge.net/htmldoc/options.html#'formatexpr'
