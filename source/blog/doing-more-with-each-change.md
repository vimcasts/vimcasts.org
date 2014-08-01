---
title: Doing more with each change
date: 2014/08/01
:tags: Essays, undo, plugins
---

I've noticed a pattern running through a few recent episodes of Vimcasts: I'll demonstrate one way of doing something, and remark that to revert the change requires two or more undos.
Then I'll demonstrate another way of doing the same thing, perhaps using functionality from a plugin, and this time I can revert the change with a single undo.
That seems to me to be a good criteria for deciding which method is better: it's the one that can be reverted with the fewest number of undos.

READMORE

### Refactoring under green

In test-driven development, we aim to follow the red, green, refactor cycle. That is: write a failing test (red), make it pass (green), then make it good (refactor). [In A Refactoring Workout: Relentlessly Green][owen], Katrina Owen describes two rules for refactoring under green:

* Run the test after every single change
* If the test fails, it should take exactly one undo to get back to green

That means that *"the size of a step is limited by what your editor can revert with a single undo."*

Can you see where I'm going with this?

### Choosing what goes into a change

If we switch to Insert mode and type an entire sentence, the undo command will remove the sentence we just typed.
Whereas if we switch to Insert mode and type only a single word, then the undo command will remove just that word.
Each time we transition between Normal mode and Insert mode, we mark the boundaries of a change.
And that gives us fine-grained control over what will happen when we invoke the undo command.

I went into more detail on this topic way back in [Vimcast episode #12 - Modal Editing: undo, redo, and repeat](/e/12). That's one of my personal favourite episodes. Watch it again!

### Examples

One of the most common typos that I make is to enter two characters in the wrong order (e.g. I might accidentally enter "ytpos" instead of "typos").
It's easily fixed: pressing `xp` will transpose the order of two characters.
But that takes two changes: `x` cuts one character from the document, `p` pastes it after the cursor.
Which means that it takes two undos to revert the edit.
In [episode #61 - Creating repeatable mappings with repeat.vim](/e/61), I created a `cp` command which would transpose two characters in a single move.
The `cp` command can be reverted with a single undo, which makes it better than `xp`.
As a bonus, Tim Pope's repeat.vim plugin makes it so you can repeat `cp` using the dot command.

In [episode #65 - Swapping two regions of text with exchange.vim](/e/65), I demonstrated how the `cx{motion}` operator allows you to swap two regions of text in one move.
An alternative workflow using copy and paste would make two separate changes to the document.
The `cx{motion}` workflow can be reverted with a single undo, so it's better than using copy and paste.
Every time that I use the exchange.vim plugin it puts a smile on my face.
Thanks to Tom McDonald for creating it!

In [episode #68 - Using selected text in UltiSnips snippets](/e/68), I demonstrated a snippet that made it possible to wrap rspec assertions in a `context` block with a single change.
The alternative workflow without using UltiSnips required 3 steps.
The UltiSnips workflow can be reverted with a single undo, so it's better.

### My Vim London presentation

At the latest Vim London meetup, I presented a talk called [Doing more with each change][abstract]. You can [watch the video][video] on Vimeo:

<div class="flex-video">
<iframe src="//player.vimeo.com/video/102142402" width="500" height="281" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe> <p><a href="http://vimeo.com/102142402">Doing more with each change, by Drew Neil</a> from <a href="http://vimeo.com/vimlondon">Vim London</a> on <a href="https://vimeo.com">Vimeo</a>.</p>
</div>

At the end of my talk, I asked the room if they could think of any other plugins that allowed you to make a modification in one move that would normally take two or more.
(Can you think of any such plugins? Leave a comment below!)
Two plugins were suggested, both created by Andrew Radev: [splitjoin][] and [switch][].
I'm going to be checking those out!

[owen]: http://www.sitepoint.com/refactoring-workout-relentlessly-green/
[abstract]: http://lanyrd.com/2014/vim-london-2/sdckkc/
[video]: https://vimeo.com/102142402
[switch]: https://github.com/AndrewRadev/switch.vim
[splitjoin]: https://github.com/AndrewRadev/splitjoin.vim
