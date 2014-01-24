--- 
:title: The copy/paste series - a retrospective
:date: 2013/11/18

---

Episodes [51][], [52][], [53][], [54][], [55][], [58][], and [59][] are all on the topic of copy and paste in Vim. I think that this is one area where Vim is especially confusing, partly because of [Vim's non-standard jargon for cut, copy and paste operations][jargon]. It's not the most intuitive copy/paste system, but it's usable when you get the hang of certain concepts and techniques.

[51]: /e/51
[52]: /e/52
[53]: /e/53
[54]: /e/54
[55]: /e/55
[58]: /e/58
[59]: /e/59
[jargon]: http://vimcasts.org/episodes/meet-the-yank-register#vim-jargon


READMORE

### The default, yank, and named registers

Vim’s *default register* makes it easy to perform some of the most basic types of cut, copy, and paste operations. That’s partly thanks to the `p` command, which behaves differently depending on whether the default register contains a characterwise or linewise region of text. As a result, we can toggle characters with `xp`, toggle lines with `ddp`, or duplicate a line with `yyp`. [Episode 51 - Simple operations using the default register][51] shows how.

The default register is not a safe place to keep yanked text that you want to paste later. It’s all too easy to clobber the default register with a `d` or `x` command. Luckily, the last yanked text is kept safe in Vim’s *yank register*. [Episode 52 - Meet the yank register][52] shows how to use the yank register.

Vim also has 26 *named registers* - one for each letter of the alphabet. These are handy if you want to cut or copy multiple regions of text that you intend to paste later. The named registers have an interesting property: as well as being able to overwrite their contents, we can also append to a named register. [Episode 53 - Using Vim's named registers][53] shows how.

### Pasting text from Visual and Insert modes

Most of Vim's commands are activated from Normal mode, but the paste command has variants that can be triggered from Visual and Insert modes. When used in Visual mode the `p` command replaces the selection with the contents of a register. This makes for a smooth workflow when you want to overwrite a selection, or swap the order of two regions of text. [Episode 54 - Pasting from Visual mode][54] demonstrates these workflows.

The `<C-r>{reg}` command lets us paste a register from Insert mode (and it works in commandline mode too!) Using this command allows us to make changes that can be repeated with the dot command. Check out [Episode 55 - Pasting from Insert mode][55] for a demonstration.

### Working with the system clipboard

Vim's registers are internal to Vim. If you want to move text between Vim and other programs running locally, you can do so using the the system clipboard, which Vim exposes through the quoteplus register: `"+`. We can use this with the delete, yank and put operations in much the same way that we use Vim’s other registers. [Episode 58 - accessing the system clipboard from Vim][58] shows how.

We can only use the `"+` register when Vim is compiled with the `+clipboard` feature. If you don't already have this feature enabled, find out [how to get Vim with `+clipboard` support][clipboard].

Even without the `+clipboard` feature, we can still insert text from the clipboard using the system paste command (`ctrl-v` or `cmd-v`). This can produce strange effects, but we can avoid them by toggling the 'paste' option each time we use the system paste command. [Episode 59 - Using Vim's paste mode with the system paste command][59] goes into more detail.

[51]: /e/51
[52]: /e/52
[53]: /e/53
[54]: /e/54
[55]: /e/55
[58]: /e/58
[59]: /e/59
[clipboard]: http://vimcasts.org/blog/2013/11/getting-vim-with-clipboard-support/
