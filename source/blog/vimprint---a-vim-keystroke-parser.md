--- 
:title: Vimprint - a Vim keystroke parser
:date: 2013/05/30
:tags: vimprint
---

I sometimes get asked what software I use to reveal the Vim keystrokes in my video tutorials here on Vimcasts.org. The fact is that I add them by hand in post-production. It's not fun!

READMORE

When I run my [Core Vim Masterclasses][class] I use [Keycastr][] to show what I'm doing in realtime. Keycastr uses Growl-style notifications to show all keystrokes across all applications, including every letter I type while communicating in a chat room, for example. It's not ideal, but it's better than nothing! I would love to have *a dedicated program for visualizing my keystrokes in Vim*, so I've started building [Vimprint][] to scratch that itch.

[class]: http://vimcasts.org/classes/core-vim
[Keycastr]: https://github.com/sdeken/keycastr/
[Vimprint]: https://github.com/nelstrom/vimprint


### My wishlist for Vimprint

My goal is to make Vimprint show all Vim keystrokes in realtime, so that I can use it when teaching Vim. In addition to showing which keystrokes were pressed, I'd like Vimprint to be able to give a bit of extra context: what does each command do, and from which mode was it triggered? Ultimately, I'd like Vimprint to handle all of Vim's built-in functionality, and for it to be extensible so that it can be made to understand commands supplied by popular plugins such as [surround.vim][].

[surround.vim]: https://github.com/tpope/vim-surround

I gave a presentation on Vimprint at this month's VimLondon meetup. You can watch the [video on Vimeo][video] and refer to the [slides on speakerdeck][slides].

[video]: https://vimeo.com/67215273
[slides]: https://speakerdeck.com/nelstrom/vimprint-a-vim-keystroke-parser

### Similar projects

In researching this topic, I've come across a few similar projects that have influenced or inspired me. (Let me know if I missed any.) [VimSpeak][] by AshleyF turns spoken English into keystrokes. Check out [this demo][spoken-golf], where the author completes a VimGolf challenge by talking to his computer. It's awesome!

Turning English into keystrokes is the opposite of what I want to do. I want to turn keystrokes into plain English descriptions, and [Vimsplain][] by pafcu is a project that does exactly that. Vimsplain is run as a batch job at the command-line. That's cool! But I want to get these kinds of explanations in realtime.

George Brocklehurst from thoughtbot has achieved that with [Vimulator][], which is a Vim Simulator (as the name suggests) that runs inside the browser. I love the way that Vimulator renders and explains keystrokes, but the task of implementing Vim in JavaScript I find daunting.

The [VimGolf client][vimgolf-client] tracks your keystrokes, and sends them to [vimgolf.com][]. It does this by launching Vim with the [`-w {scriptout}`][scriptout] option, which logs all keystrokes to the specified `{scriptout}` file.

That seems like a good starting point, but there's a problem with the `-w {scriptout}` option: it only writes keystrokes to the specified file when Vim exits. To create a realtime visualization, I would need a realtime stream of keystrokes.

[Kana Natsuno][kana] (one of my Vim heroes) came up with this [single-line patch][patch], which disables buffering of the `-w` option. With a custom build of Vim using my [live-stream-keystrokes][fork] branch of MacVim, I can get the realtime stream of keystrokes that I need. Sweet! Now I just need to parse it.

[VimSpeak]: https://github.com/AshleyF/VimSpeak
[spoken-golf]: http://www.youtube.com/watch?v=qy84TYvXJbk
[Vimsplain]: https://github.com/pafcu/Vimsplain
[Vimulator]: https://github.com/thoughtbot/vimulator
[vimgolf-client]: https://github.com/igrigorik/vimgolf
[vimgolf.com]: http://www.vimgolf.com/
[scriptout]: http://vimdoc.sourceforge.net/htmldoc/starting.html#-w
[kana]: https://github.com/kana
[patch]: https://gist.github.com/kana/4202311
[fork]: https://github.com/nelstrom/macvim/commit/c65e7e650b806682152681c58078d29cb1904bfe

### Parsing Vim keystrokes with Ragel

[Ragel][ragel] is a *state machine compiler*, which seems like a good fit for this problem. After all, Vim itself is a [finite state machine][fsm] of sorts.

As a demonstration, I've created a [`simple.rl`][simple] ragel program that parses a tiny subset of Vim's commands. Install ragel (`brew install ragel` on a mac), then you can compile and run this program:

    ragel -R simple.rl
    ruby simple.rb

As well as compiling executable Ruby code, Ragel can generate `.dot` graphs, which can be viewed using [Graphviz][]. Here's the state chart visualization of the `simple.rl` program (created with the command `ragel -Vp simple.rl`):

<img src="http://vimcasts.org/images/blog/simple_state_transitions-large.png" width="480" height="333" alt="simple Vim state machine"/>

I've found this kind of visualization to be very helpful in debugging Ragel programs.

### Contributions welcome

This is an ambitious project. I'd welcome any help on it that I can get. If you'd like to [\#pairwithme][] on Vimprint, then [please get in touch](mailto:drew@vimcasts.org).

I'll be presenting a session on *Modelling State Machines with Ragel* at [Eurucamp][] this year. I'd love to be able to demonstrate Vimprint in action by that date.

[ragel]: http://www.complang.org/ragel/
[fsm]: https://en.wikipedia.org/wiki/Finite-state_machine
[simple]: https://github.com/nelstrom/vimprint/blob/9ad2faca4001bf6cc1282c2cb0a245f08d06422c/lib/ragel/simple.rl
[Graphviz]: http://www.graphviz.org/
[Eurucamp]: http://2013.eurucamp.org/speakers
[\#pairwithme]: http://www.pairprogramwith.me/
