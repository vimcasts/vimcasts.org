--- 
:title: "Registers: the Good, the Bad, and the Ugly Parts"
:date: 2013/11/25
:tags: registers, Essays, Copy and Paste
---

To the newcomer, Vim's way of doing things may seem strange, but with familiarity it becomes natural. Many of Vim's features seemed odd to me at first, but when I got used to them I recognised that they had their own particular elegance. However, there's one feature of Vim that still feels awkward to me: using registers for copy and paste. The deeper my understanding of registers becomes, the more they frustrate me!


READMORE

### The Good Parts

There's plenty to like about Vim's registers. I've produced [a series of 7 screencasts][summary] that go into depth about how registers can be used for copy and paste. As far as I'm concerned, that's all good stuff. But registers aren't only useful for copy and paste. We can also create and execute macros, by recording our keystrokes into a register then playing back those keystrokes later.

The fact that registers are multi-purpose means that after recording a macro we can easily make changes to it. For example, we could record our keystrokes into a register, then paste that register into the document, edit the keystrokes in place, then yank the modified version back into a register. (See [Practical Vim][pv], tip 71: *Edit the contents of a macro* for a demonstration.) I like that flexibility.

I also like how Vim exposes useful information through the [search][quote/] and [read-only registers][readonly]: `@/` contains the current search pattern, `@:` contains the last Ex command, `@.` contains the last inserted text, and `@%` contains the filename of the current buffer.

[summary]: http://vimcasts.org/blog/2013/11/the-copypaste-series-a-retrospective/
[pv]: https://pragprog.com/titles/dnvim2/practical-vim-second-edition
[readonly]: http://vimdoc.sourceforge.net/htmldoc/change.html#quote_.
[quote/]: http://vimdoc.sourceforge.net/htmldoc/change.html#quote_/


### The Bad Parts

The registers numbered `"1` through `"9` are a source of frustration for me. If you skim-read [the documentation for Vim's numbered registers][quote1] they sound promising:

> Vim shifts the previous contents of register 1 into register 2, 2 into 3, and so forth, losing the previous contents of register 9.

It seems as though the registers numbered `"1` - `"9` provide something like a clipboard history, which sounds handy. This would be further enhanced by a little-known feature of the `.` command: when used to repeat `"1p`, the dot command increments the register number (see [:help redo-register][redo-register]):

> you can use a special feature of the repeat command `.`. It will increase the number of the register used. So if you first do `"1P`, the following `.` will result in a `"2P`. Repeating this will result in all numbered registers being inserted.

Not only does Vim maintain a sort of clipboard history, but it also provides a convenient method for iterating through the clipboard history. That sounds like a good thing, so why have I filed this under 'The Bad Parts'?

[quote1]: http://vimdoc.sourceforge.net/htmldoc/change.html#quote1
[redo-register]: http://vimdoc.sourceforge.net/htmldoc/undo.html#redo-register

There's a catch: Vim never writes yank operations to register `"1`. Instead, yanked text is written to register `"0`, which is isolated from the mechanism that propagates values through `"1` to `"9`. That means that the clipboard history is incomplete. Registers `"1` - `"9` only record deletions, not yanks.

And when I say that registers `"1` - `"9` only record deletions, I have to add a further caveat: if the range of text being deleted spans less than one line, it will be written to `"-`, the *small delete register*. That is, unless you prefix the delete operation with a named register. In that case, the text will be written to the named register and to register `"1`, but not to `"-`.

I've compiled a table showing which registers are populated by various combinations of yank/delete operations, over a characterwise/linewise range, with or without a named register (see [this gist][gist] for details of how I compiled this information):

<table>
  <tr>
    <th>operation</th>
    <th><code>""</code> (default)</th>
    <th><code>"0</code> (yank)</th>
    <th><code>"1</code> (numbered)</th>
    <th><code>"a</code> (named)</th>
    <th><code>"-</code> (small&nbsp;delete)</th>
  </tr>

  <tr>
    <td><code>yw</code></td>
    <td>X</td>
    <td>X</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>

  <tr>
    <td><code>yy</code></td>
    <td>X</td>
    <td>X</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
  </tr>

  <tr>
    <td><code>"ayw</code></td>
    <td>X</td>
    <td>-</td>
    <td>-</td>
    <td>X</td>
    <td>-</td>
  </tr>

  <tr>
    <td><code>"ayy</code></td>
    <td>X</td>
    <td>-</td>
    <td>-</td>
    <td>X</td>
    <td>-</td>
  </tr>

  <tr>
    <td><code>dw</code></td>
    <td>X</td>
    <td>-</td>
    <td>-</td>
    <td>-</td>
    <td>X</td>
  </tr>

  <tr>
    <td><code>dd</code></td>
    <td>X</td>
    <td>-</td>
    <td>X</td>
    <td>-</td>
    <td>-</td>
  </tr>

  <tr>
    <td><code>"adw</code></td>
    <td>X</td>
    <td>-</td>
    <td>X</td>
    <td>X</td>
    <td>-</td>
  </tr>

  <tr>
    <td><code>"add</code></td>
    <td>X</td>
    <td>-</td>
    <td>X</td>
    <td>X</td>
    <td>-</td>
  </tr>
</table>

There are so many idiosyncrasies in this table that it's hard to decide what's a rule and what's an exception! It's needlessly complicated. If you're considering committing this chart to memory, I would urge you not to bother.

[gist]: https://gist.github.com/nelstrom/7615833

### The Ugly Parts

Vim uses non-standard terminology to describe cut, copy, and paste operations. As I've [noted before][jargon]: 'put' and 'paste' are easily interchangeable, and the word 'yank' becomes synonymous with 'copy' when you get used to it, but Vim's use of the word ‘delete’ is problematic. 

In most text editing contexts the word delete means *remove*. But Vim's delete operation copies the text into a register, then removes it from the document. In other words, Vim's delete operation behaves like the standard cut command. I find Vim's terminology to be unhelpful, so I try to make a point of describing the `d{motion}` command as “cut the specified text” (rather than “delete the specified text”). Likewise for `x`, `c`, `s`, and so on.

The fact that `x`, `s`, `d`, and `c` all *cut by default* makes it awkward to perform a true deletion. To really delete text (without writing to a register), we have to prefix each of these commands with `"_`, the blackhole register. That's bizarre! More often than not, when I use Vim's delete operation, I only want to remove the text from the document. I don't want to write it to a register and I consider that to be an unfortunate side-effect.

On the other hand, I definitely want to write the text to a register when I use the yank command (after all, that's the only thing it does!). It's frustrating that the yank command writes to `"0`, overwriting my previous yank. Whereas the delete command writes text that I may not even want to keep to `"1`, preserving the previous eight deletions in registers `"2` - `"9`.

[jargon]: http://vimcasts.org/episodes/meet-the-yank-register#vim-jargon

### So what?

*Cut* is not a sensible default behaviour for a command named 'delete'. The terminology is misleading, but the behaviour itself is also unfortunate. Vimcasts episode #52, [Meet the yank register](/e/52), shows an example workflow where this behaviour acts as an impediment. It would be better if Vim provided two distinct commands: the delete operation would only remove text from the document, while the cut operation would remove text from the document and write it to a register. That Vim's `x`, `s`, `d`, and `c` "delete operations" write text to a register is ugly.

I can't find any redeeming features in the behaviour of Vim's numbered registers, which makes me think they're just plain bad. They get almost half-way to behaving as a proper clipboard history, but that's not good enough. A half-cooked feature is a feature wasted.

I've learned to live with the good parts of Vim's copy/paste feature set.
The good parts are good enough to get by with, but they're not as good as they could be.
That frustrates me.

I have written my thoughts on how to fix Vim's registers in the form of a [README for cutlass.vim](https://github.com/nelstrom/vim-cutlass) - a plugin that doesn't yet exist. I'd also like to give a shout out to Steve Vermeulen, who has already implemented some of the same features that I sketched (and many more features besides) in his [vim-easyclip][] plugin, which you can install and use today.

[vim-easyclip]: https://github.com/svermeulen/vim-easyclip
