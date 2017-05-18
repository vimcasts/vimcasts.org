---
:title: "Working title: Modern Vim"
:date: 2017/05/17
:tags: Modern Vim
---

I'm happy to announce that **I'm working on a new book**.
My working title is *Modern Vim*.
It's a sequel to *Practical Vim*, and this too will be published by the [Pragmatic Bookshelf][prags].

[prags]: https://pragprog.com/book/modvim/modern-vim

READMORE

### Why "Modern Vim"?

Some will scoff at the name *Modern Vim*.
["*Practical Vim* is an oxymoron"][oxymoron] they said.
Bring on the jokes, I say!

Version 8.0 of Vim [was released in September 2016][release], with [new features][version8-features] such as packages and job control.
These features have little impact on Vim's core, but they empower plugin authors to do things that were previously impossible.
*Practical Vim* focussed entirely on Vim's core functionality, so these new features are beyond the scope of that book.
In *Modern Vim*, I’ll consider Vim 8 as a requirement.
Many of the tips will feature plugins that exploit these new features.

I'm also going to dedicate some of this book to Neovim.
I've been using Neovim for over a year now and I think it's the future of Vim.
Neovim comes with a built-in terminal emulator, which has transformed my workflow.

Most of the book will be about Vim 8, but in the final chapter(s) I'll introduce Neovim.
I hope that the Neovim features will be appealing enough to make you want to try it out.
The best bit is that all of the tips written for Vim 8 will also work in Neovim.

I don't expect to make any major updates to *Practical Vim*.
The book is complete and most of the content is evergreen.
As Vim and Neovim continue to grow and adapt, I'll be revising *Modern Vim* to keep it fresh.

### Who is the book for?

Broadly speaking, there are two types of Vim users: those who use it for convenience, because Vim is ubiquitous (casual users); and those who invest time in customising their editor to be their development environment (serious users).
*Practical Vim* appealed to both of these types of users.
*Modern Vim* will mainly appeal to the serious users.
(That's you!)

This book will get you up to speed with what's new in version 8 of Vim.
You'll find out how to install plugins using the built-in packages feature.
Some tasks that used to block the editor can now be performed asynchronously, allowing you to continue using Vim while they run in the background.
This gives a better user experience when doing things like linting, grepping, building a project, or running a test suite.

If you enjoy using tmux and Vim together, then I think you're going to love Neovim's terminal emulator.
Being able to treat a terminal buffer just like any other buffer was a game changer for me.
The terminal buffers fit naturally with Vim's split windows, and you can use Normal mode commands to scroll, search, copy, and paste.
On top of all that: Neovim's terminal buffers are scriptable.

### My goals

*Practical Vim* was written in the style of a recipe book, made up of 120 self-contained tips.
This format worked really well and I'll be adopting the same style for the sequel.
I'm aiming to write 20-30 tips for the first edition of *Modern Vim*.

It took me 18 months to write *Practical Vim*.
I now have a family to support, so I don't have that kind of time anymore!
I hope to have *Modern Vim* finished in 6 months.

[oxymoron]: https://twitter.com/beautyon_/status/608531133484118016
[release]: https://github.com/vim/vim/releases/tag/v8.0.0000
[version8]: http://vimhelp.appspot.com/version8.txt.html#version8.txt
[version8-features]: http://vimhelp.appspot.com/version8.txt.html#new-8
