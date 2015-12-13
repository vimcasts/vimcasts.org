--- 
:title: What's new in Practical Vim, 2nd edition
:date: 2015/11/23
:tags: Practical Vim
---

The first edition of *Practical Vim* was published in 2012.
Vim has continued to evolve in the three years since, making some of the material out of date.
We've just published a [2nd edition of *Practical Vim*][dnvim2] (Pragmatic Bookshelf, 2015) with updated material and some new tips.

[dnvim2]: https://pragprog.com/book/dnvim2/practical-vim-second-edition

READMORE

### Should you buy the 2nd edition of *Practical Vim*?

If you are considering buying *Practical Vim* for the first time, the 2nd edition is the one you should get.
It contains all of the same material as the 1st edition, but with corrections and revised material to bring the book up to date with version 7.4 of Vim.

If you bought the ebook version of the 1st edition direct from the Pragmatic Bookshelf, then you can [get a free upgrade to the ebook version of the 2nd edition][upgrade].
If you bought the ebook version elsewhere, you'll have to pay to upgrade.

### What *Practical Vim* covers

Vim is a huge topic, and I could have easily written a 600 page book on the subject.
My publisher made it clear to me that they wouldn't publish a 600 page book on Vim, and I should try to keep it under 300 pages!
That meant that I had to give myself some strict rules about what I could and what I could not write about.

I decided that I should aim to only write about core Vim functionality.
I should not assume that the reader has any plugins installed.
However, I could reference plugins in the occasional sidebar.
Also, I would avoid discussing Vimscript, since that is a large enough topic to deserve a book of its own.

## Revised material

The following tips were completely rewritten.

### Using the new gn command

I always thought that Vim should provide some method of operating on a search match.
I used to use the [`textobj-lastpat` plugin][lastpat] by Kana Natsuno to get this functionality.
I considered this feature to be so vital that I wanted to write about it in *Practical Vim*, but I couldn't do so without violating my *no plugins assumed* rule.
So I had to find a way of making this work using core Vim features only.
The method that I wrote about in the first edition used the [`search-offset`][offset] feature to achieve the same effect, but the workflow was awkward.
I ended the tip by saying "For a better workflow, read the sidebar about the `textobj-lastpat` plugin."
That was my sneaky way of referencing what I considered to be an essential plugin, without breaking my *no plugins assumed* rule.

The [`gn` command][gn], implemented by Christian Brabandt, gives us a much more elegant way of operating on a search match.
This command has been available in core Vim since [patch 7.4.110][110].
I've updated **Tip 84 - Operate on a Complete Search Match** to use the gn command
(and I removed the sidebar referencing the `textobj-lastpat` plugin).
I also covered this technique in Vimcasts [Episode 63 - Operating on search matches using gn](/e/63).

[lastpat]: https://github.com/kana/vim-textobj-lastpat
[offset]: http://vimhelp.appspot.com/pattern.txt.html#search-offset
[110]: https://github.com/vim/vim/commit/ba2d44f33863e115b1858ab572829f403ad21883
[gn]: http://vimhelp.appspot.com/visual.txt.html#gn

### Find and replace across multiple files

In the 1st edition, tip 96 offered a solution for running the substitute command across multiple files.
The basic strategy was simple: use `:vimgrep` to populate the quickfix with matches for the specified pattern, then execute the `:substitute` command on each of those matches.
But there was a problem with this strategy: Vim didn't make it easy to execute a command on each match.
In the 1st edition, I remarked that:

> It would be convenient if Vim included a :quickfixdo command, but there is no such thing. So instead we’ll use a small snippet of Vim script [to create a `Qargs` command][qargs]

This is one of the places in *Practical Vim* where I had to resort to using Vimscript to provide some functionality that wasn't availble in core Vim.
The `Qargs` command simply populated the argument list with each of the files referenced in the current quickfix list.
Having run `:Qargs`, we can then use the `:argdo %s/pattern/replacement/g` command to execute our substitute command across each of the matches.

Vim already has several commands that let us execute a command against all of the items in one list or another: there's `:argdo`, `:bufdo`, `:windo`, and `:tabdo`.
I thought that it would useful if there was a similar command for interacting with the items in the quickfix list.
Yeggapan Lakshmanan thought so too and went ahead and implemented the feature.
Since [Patch 7.4.858][858], we can now use `:cfdo` to execute an Ex command against each file in the quickfix list. (That patch also added the `:cdo` command, as well as `:lfdo`, and `:ldo`.)

I've rewritten the **Find and Replace Across Multiple Files** tip to use the `:cfdo` command, and I've removed the reference to the `:Qargs` vimscript, since it's no longer needed.

[858]: https://github.com/vim/vim/commit/aa23b379421aa214e6543b06c974594a25799b09
[qargs]: https://github.com/nelstrom/vim-qargs

### Improvements to the :vimgrep command

In tip 110 **Grep with Vim's internal search engine** of the 1st edition, I said: 

> you might be wondering what happens if we leave the pattern field empty. Not what you would expect, sadly. If we leave the pattern field empty, the :vimgrep command matches every line in every file that it looks inside.

David Bürgen read this and took it upon himself to fix that bug, with [patch 7.3.850][850].
Now, if we run this command:

    :vimgrep // {file}

Vim will look in the specified `{file}`s for text that matches *the current search pattern*.
(This is similar to how the `:substitute` and `:global` commands work with a blank search field)

In the first edition, I didn't spend long talking about the `:vimgrep` command because I was frustrated by that bug.
Now that `:vimgrep` works the way I expect it to, I find the command much more satisfying to use!
I've completely rewritten the `:vimgrep` tip, giving more examples of usage.

I've also updated Tip 82 **Count the Matches for the Current Pattern** (it's become Tip 86 in the 2nd edition). Previously, I suggested a method of counting matches using the substitute command with the `gn` flags:

    :s///gn
    => 5 matches on 4 lines

I've revised that tip to include this alternative:

    :vimgrep //g %
    => (1 of 5)

I learned this technique since writing the first edition and I've found it useful, so I wanted to include it in the 2nd edtion.

## Brand new tips

I've also written two brand new tips for this 2nd edition:

* Tip 36 - Run multiple Ex commands as a batch
* Tip 117 - Autocomplete sequences of words

These feature a couple of tricks that I've learned since I wrote the 1st edition.

## What didn't make it into the 2nd edition

In the chapter **Index and Navigate Source Code with ctags**, I recommend using *Exuberant Ctags*.
The Exuberant Ctags project has not been updated since 2009.
I'm keeping my eye on the [Universal ctags][ctags] project (they got me with the strapline: "A maintained ctags implementation"), which [aims to][intent]:

> provide a modernized version of exuberant ctags with more features and active, community-driven maintainership

The project is not at a 1.0 release, and I felt that it was not yet mature enough to feature it in *Practical Vim*.
When it is ready, I'll be updating that chapter of my book to recommend installing Universal Ctags instead of Exuberant Ctags.

[ctags]: https://github.com/universal-ctags/ctags
[intent]: https://github.com/universal-ctags/ctags/issues/446#issuecomment-122971751

## Revised help hyperlinks

Throughout *Practical Vim*, I make frequent references to Vim's built-in documentation.
I specify these references so that they are useful to people reading the printed version of the book, by showing how to look up the entry from inside of Vim.
But I also mark up these references as a hyperlink, so that people reading the ebook edition can click the link and view the documentation.

In the 1st edition, I used the [online documentation published on sourceforge][old-help].
This resource has not been updated since 2010, which wasn't a big problem when the 1st edition came out.
But in the 2nd edition, I have written about features that have been released with version 7.4 of Vim.
I needed a more up to date version of the documentation online.

Luckily, I found [vimhelp.appspot.com][new-help], a site published and maintained by Carlo Teubner.
This is automatically updated for each patch release of Vim, so it's always up to date.
That means that I can reference all of the latest features, including the recently added [`:cfdo` command][cfdo].

I went through every help reference in the book and changed it to point at vimhelp.appspot.com, instead of vimdoc.sourceforge.net.
There were over 200 such references!
If only there was some convenient way of making Vim do a find and replace across multiple files...

<a href="https://media.pragprog.com/newsletters/2015-11-23.html" class="button expand">Get 40% off Practical Vim, 2nd edition</a>

[850]: https://github.com/vim/vim/commit/60abe75379f8b7c2076856c5f12ce2e7650110f7
[upgrade]: http://vimcasts.org/blog/2015/11/upgrade-to-practical-vim-2nd-edition/

[new-help]: http://vimhelp.appspot.com/
[old-help]: http://vimdoc.sourceforge.net/htmldoc/index.html
[cfdo]: http://vimhelp.appspot.com/quickfix.txt.html#%3Acfdo
