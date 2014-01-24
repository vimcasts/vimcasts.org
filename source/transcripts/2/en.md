Vim offers very granular control over whitespace. There are 4 settings that
can be tweaked:

* **tabstop** - specifies the width of a tab character
* **expandtab** - when enabled, causes spaces to be used in place of tab characters
* **softtabstop** - when enabled, fine tunes the amount of whitespace to be inserted
* **shiftwidth** - determines the amount of whitespace to insert or remove using the indentation commands in normal mode

The best way to illustrate how each of these settings works is to show
examples with different settings.

Defaults: ts=8 sts=0 sw=8 noexpandtab
-------------------------------------

By default, Vim sets tabstop to 8, with expandtab switched off. This means
that pressing the tab key in insert mode inserts a single tab character, whose
width is 8 columns. The backspace key, unsurprisingly, deletes the tab character.

In normal mode, we can use the `>` [greater-than] command to
shift a selection right, and this is achieved by prepending a single tab
character at the beginning of each selected line. The `<`
[less-than] command shifts the selected text left by deleting a
single tab character.

ts=8 sts=0 sw=8 expandtab
-------------------------

Lets begin by switching expandtab on. This causes the tab key to insert
space characters of an equivalent width to the tab which would have otherwise
been inserted, if expand tab was not enabled. The backspace key, however, just
deletes a single space at a time. We'll look at how to fix this in a minute.

In normal mode, the `>` command shifts a selection to the right by prepending
8 space characters at a time, while the `<` command does the inverse.

ts=8 sts=8 sw=8 expandtab
-------------------------

By setting `softtabstop` to 8, the same value as `tabstop` and `shiftwidth`,
we can fix the behaviour of the backspace key in insert mode. Now, pressing
backspace removes up to 8 spaces. So we can use the tab key to indent, by
adding 8 spaces, and the backspace key to go the other way.

The behaviour of the indentation commands in normal mode is the same as
before, because we have not altered the `shiftwidth` setting.

As a general rule, you want to make sure that `softtabstop` and `shiftwidth`
are equal. That way, you can expect consistent behaviour, whether you are
shifting left and right with the indentation commands in normal mode, or you
are inserting and removing spaces with tab and backspace keys in insert mode.

ts=8 sts=4 sw=4 expandtab
-------------------------

Lets look at an example where tabstop differs from softtabstop and shiftwidth.
We'll keep tabstop set at the default value of 8, and take softtabstop and
shiftwidth down to 4, keeping expandtab enabled for now. 

In insert mode, pressing the tab key inserts 4 spaces. Pressing it again
inserts another 4 spaces, and so on. The backspace key works in the opposite
direction, removing 4 spaces at a time. 

In normal mode, the indentation commands also work in increments of 4 spaces.

Having expandtab enabled means that we are always inserting spaces rather than
tab characters. But if any tab characters are present, their width is still
dictated by the `tabstop` setting, which is 8.


ts=8 sts=4 sw=4 noexpandtab
---------------------------

Now lets try maintaining these settings, but switching expandtab off.
Expandtab tells Vim to work with spaces instead of tabs, so by disabling it,
we are back to working with tabs. 

Here we have tabstop set at 8, and softtabstop at 4. Softtabstop takes
precedence, so when we press tab in insert mode, Vim tries to insert
whitespace with a width of 4. The only way it can do this is to insert 4
spaces, because tab characters have width of 8. If we press tab a second time,
it removes the 4 spaces and replaces them with a single tab character, whose
width is 8. The backspace key works in reverse, converting a tab character to
4 spaces, then removing 4 spaces in succession.

We have set shiftwidth to 4 as well, so in normal mode, the indentation
commands behave in a similar fashion. 

ts=4 sts=4 sw=4 noexpandtab
---------------------------

Finally, lets try bringing tabstop down to 4. As we apply this change, we should see the existing tabs shrinking in width from 8 columns to 4. Now that there is no discrepancy between tabstop and softtabstop, we can expect tab characters to be inserted every time, whether we press the tab key in insert mode, or use the indentation commands in normal mode. 

Setting ts = sts = sw simultaneously
------------------------------------

If you prefer to work with tab characters, and you don't want to throw spaces into the mix, then it is a good idea to ensure that `tabstop` always equals `softtabstop`. 

As I mentioned earlier, if you prefer to work with spaces, then it is preferable to ensure that `softtabstop` always equals `shiftwidth`. 

So it would be most convenient if we could assign the same value to tabstop, softtabstop and shiftwidth simultaneously. Here is a little bit of vimscript that allows you to do just that. Copy this code from the shownotes directly into your .vimrc file:

    " Set tabstop, softtabstop and shiftwidth to the same value
    command! -nargs=* Stab call Stab()
    function! Stab()
      let l:tabstop = 1 * input('set tabstop = softtabstop = shiftwidth = ')
      if l:tabstop > 0
        let &l:sts = l:tabstop
        let &l:ts = l:tabstop
        let &l:sw = l:tabstop
      endif
      call SummarizeTabs()
    endfunction
    nmap <C-S-Tab> :call SummarizeTabs()<CR>
    function! SummarizeTabs()
      try
        echohl ModeMsg
        echon 'tabstop='.&l:ts
        echon ' shiftwidth='.&l:sw
        echon ' softtabstop='.&l:sts 
        if &l:et
          echon ' expandtab'
        else
          echon ' noexpandtab'
        end
      finally
        echohl None
      endtry
    endfunction

This adds a command which is invoked as `:Stab` ["colon-capital-S-tab"]. You are prompted for a value, which will be assigned to tabstop, softtabstop and shiftwidth at once. A summary line then shows the value of each of these, as well as showing whether or not expandtab is enabled. If you hit enter without providing a value, then the tab settings are not affected.

You can also call the summary line by itself. I've mapped this to control-shift-tab for convenience. Feel free to modify the mappings, and the functionality to suit your preferences.