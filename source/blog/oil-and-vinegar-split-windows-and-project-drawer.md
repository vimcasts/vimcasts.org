--- 
:title: Oil and vinegar - split windows and the project drawer
:date: 2013/01/02

---

Do you avoid using Vim's split windows because they're confusing? That might be a problem of your own devising. If you've bolted a project drawer onto Vim, then you've added unnecessary complexity to Vim's otherwise minimal interface. Split windows and the project drawer go together like oil and vinegar. I don't mean to say that you can combine them to create a delicious salad dressing. I mean that they don't mix well!

READMORE

<r:snippet name="announcement"/>

###The project drawer (you've already met)

Picture your typical GUI based text editing environment. The standard interface usually features a file explorer in a sidebar. It's sometimes called the *project drawer*, because it can slide out of view when it's not being used. I'm sure you know what I'm talking about, but here's a screenshot just in case:

![Screenshot of TextMate's project drawer](/images/blog/textmate-project-drawer.png)

I'm not a big fan of file explorers. I usually find it quicker to open files using a fuzzy-file matcher plugin such as [cmd-t][] or [ctrl-p][] for Vim. But I wouldn't write off the file explorer entirely. It still has its place, particularly during the orientation phase with a new codebase.

[slide]: http://gif-of-drawer-slideing-in-and-out-of-view
[cmd-t]: https://github.com/wincent/Command-T
[ctrl-p]: https://github.com/kien/ctrlp.vim

###The problem with project drawers

Picture this scenario: we've got 3 split windows visible at once, and we want to open another file.

![Screenshot of 3 split windows with a bolt-on project drawer](/images/blog/explorer-drawer.png)

If we select a file in the project drawer, which split window will it appear in?

It's difficult to tell just by looking. The sensible default would be for the new file to open in whichever split window was last active. The most recently touched split window has the *focus*, so that's where the new file should open when selected in the project drawer.

It works, but this solution lacks clarity. It's easy to imagine a scenario where the user mistakenly thinks that window C has the focus, when in fact the focus belongs to window A. Think of the confusion that would be caused when a file selected in the project drawer replaced the contents of window A instead of appearing in window C.

To recover from this mistake in Vim, you could activate window A and switch to the alternate file by pressing `<C-^>` ([:help ctrl-^][ctrl6]). Then activate window C, switch back to the project drawer and select the target file. That's a lot of clean up for a simple mistake. Beware of [gumption traps][] such as this!

[ctrl6]: http://vimdoc.sourceforge.net/htmldoc/editing.html#ctrl-^
[gumption traps]: http://en.wikipedia.org/wiki/Gumption_trap

###An alternative to the project drawer: the split explorer

Here's the same scenario with the project drawer removed:

![Illustration of 3 split windows, with buffers a, b, and c](/images/blog/explorer-split-1.png)

In this illustration, I've shaded window C to indicate that it has the focus. Suppose that we could invoke a command that would draw a file explorer *inside of split window C*. It might look something like this:

![Illustration of 3 split windows with a file explorer in place of c](/images/blog/explorer-split-2.png)

When we select an item in this file explorer, it would open up the specified file in the same split window:

![Illustration of 3 split windows, with buffers a, b, and d](/images/blog/explorer-split-3.png)

Think of it like this: each split window can either act as a view onto the contents of a file, or it can act as a view onto the contents of a directory. You might even say that each window has a 'file viewing mode' (the usual view) and a 'directory viewing mode' (the file explorer). I find that it helps to imagine a [card-flip transition][flip] as the window shifts between file and directory viewing modes.

[flip]: http://desandro.github.com/3dtransforms/examples/card-02-slide-flip.html

This model has a distinct advantage over the project drawer: it's clear which of the split windows will receive the file selected in the explorer. If you were to accidentally activate the file explorer whilst focussed on the wrong window then you would know (and be able to revert) immediately. That leads to fewer errors and less confusion.

More importantly: it makes it really easy to use Vim's split windows. And that's a good thing, because Vim's split window functionality is *awesome*!

###Vim's split windows are awesome

We can easily divide Vim's interface into split windows. The [`<C-w>s`][split] command splits the current window horizontally, while the [`<C-w>v`][vsplit] command divides the current window vertically. This figure illustrates a few of the possible results. In each case, the shaded rectangle represents the active window:

![illustration showing cell division](/images/blog/cell-division.png)

[split]: http://vimdoc.sourceforge.net/htmldoc/windows.html#CTRL-W_CTRL-S
[vsplit]: http://vimdoc.sourceforge.net/htmldoc/windows.html#CTRL-W_CTRL-V

When dividing a window in this manner Vim reuses the active buffer in the new window, so you end up with two views onto the same file. I like to think of the process as resembling [cell division][]!

Vim's split-window feature is really flexible and easy to use. If you're not making full use of it, you're missing out! Vimcasts Episode 7 demonstrates [how to use Vim's split windows][7].

[cell division]: http://en.wikipedia.org/wiki/Cell_division
[7]: http://vimcasts.org/episodes/working-with-windows/

###NerdTree is a project drawer, netrw is a split explorer

[NerdTree][nerd] is one of the most popular plugins for Vim. It implements a file explorer using a model that resembles the project drawer. There's a less well-known file explorer plugin for Vim called [netrw][]. It's not quite as polished as NerdTree, but it gets one thing right: it uses the split explorer model.

[nerd]: http://www.vim.org/scripts/script.php?script_id=1658
[netrw]: http://www.vim.org/scripts/script.php?script_id=1075

If you're a NerdTree user and curious to try this approach, you've got a couple of options. You could add this to your vimrc, which modifies NerdTree to make it use the split explorer model:

    let NERDTreeHijackNetrw=1

Or you could uninstall NerdTree and use the netrw plugin instead. The netrw plugin is usually included in the Vim distribution by default, so you don't need to do anything to install it. For more details, refer to episode 15 of Vimcasts: [The File Explorer][netrw]

###Like oil and vinegar, the project drawer and split windows don't mix

The project drawer works well in an interface where you can only view one file at a time, but the concept does not translate to the split-window interface. When working with multiple files in split windows, the split explorer is a better fit.

The illustrations in this blog post are adapted from [Practical Vim][pv]. For more discussion, please refer to *Tip 43 Explore the file system with netrw* and *Tip 39: Divide your workspace into split windows*.

[netrw]:  http://vimcasts.org/e/15
[pv]: http://pragprog.com/book/dnvim/practical-vim