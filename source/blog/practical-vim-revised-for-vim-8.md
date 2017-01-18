--- 
:title: Practical Vim, revised for Vim 8
:date: 2017/01/18
:tags: Practical Vim
---

I've revised [the second edition of Practical Vim][dnvim2], bringing it up to date with Vim 8.
If you bought the ebook direct from Pragmatic Bookshelf, then you'll receive the update for free.

[dnvim2]: https://pragprog.com/book/dnvim2/practical-vim-second-edition

READMORE

As Vim continues to evolve, I want to make sure that the advice in Practical Vim stays relevant.
The introduction to the book has this to say "On Vim versions":

> All examples in <em>Practical Vim</em> were tested on the latest version of Vim, <strong>which was 8.0 at the time of writing</strong>. That said, version 7.3 is modern enough to include most of functionality covered in this book, with a couple of exceptions. I'd encourage you to install an up-to-date version of Vim if you can, so that you can benefit from these improvements.

For more details on the new features in Vim 7.4, see my blog post on [what's new in the 2nd edition][new-in-2]

### What's new in Vim 8

Most of the new functionality in Vim 8 falls outside of the scope of Practical Vim.
I've written a couple of paragraphs that call out some of the highlights, which I'll reproduce here:

> Version 8.0 of Vim was released in September 2016. In earlier versions, Vim would run in vi-compatible mode by default, but in version 8 you have to explicitly opt-in to running in vi-compatible mode. In theory this could break compatibility for some plugins that worked in Vim 7, making them unusable in Vim 8. However, most plugins assume that vi-compatible mode disabled anyway, so this backward incompatible change is unlikely to cause issues in practice. Even so, this potentially breaking change justifies the major bump from version 7.4 to 8.0.

> The most significant new features in Vim 8 are enhancements to Vim script. Vim now supports job control and asynchronous I/O, which means we can start and stop external processes, and communicate with them by exchanging messages in the background. This is useful for tasks such as syntax checking and generating auto-completion suggestions. Previously such processes had to run synchronously, causing Vim to be non-responsive until the process completed. Now these processes can run in the background, which makes everything feel more snappy and responsive.

I had to make a few alterations throughout the book, especially when referring to Vim's default settings.
While I was at it, I took the opportunity to fix some of the errata that readers had reported.
This is a fairly minor revision on the whole, but it keeps the book fresh.

### How to upgrade your ebook

If you bought the ebook edition of the 2nd edition from Pragmatic Bookshelf, then you can get the update by logging in to your [Bookshelf Home Page](http://pragprog.com/my_account).

If you bought the ebook version of the 1st edition direct from the Pragmatic Bookshelf, then you can [get a free upgrade to the ebook version of the 2nd edition][upgrade].

If you bought the ebook version elsewhere, you'll have to pay to upgrade.

[new-in-2]: /blog/2015/11/whats-new-in-practical-vim-2nd-edition/
[upgrade]: /blog/2015/11/upgrade-to-practical-vim-2nd-edition/
