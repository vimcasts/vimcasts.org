--- 
:title: Creating the Vimcasts logo as ASCII art
:date: 2010/03/14
:poster: /images/posters/ascii.png
:flattr_id: "31932"
:duration: 347
:number: 10
:tags: Visual mode, Repetition, substitution, Editing text, Regular expressions
---

Demonstrating miscellaneous tips and tricks gleaned whilst making an ASCII art version of the VimCasts.org logo. Learn how to duplicate lines, copy and paste with visual block mode, search and replace within a visual selection, and how to use macros.



READMORE


In this episode, I demonstrate how to make an [ASCII art][ascii] version of the [Vimcasts.org logo][logo]. Rather than focussing on a single feature, I demonstrate a handful of miscellaneous tips and tricks as they come up in the course of editing the ASCII art. 

If you want to practise these commands for yourself, you can [download the file][ascii] that I used to create this episode.

### Convert leading spaces to underscores ###

The command used to convert leading spaces to underscores was: `vwr_`. This was then recorded as a macro in register 'a' as follows:

    qavwr_jq

This can then be replayed once with `@a`, or multiple times by prepending a count, e.g. `8@a`.

### Copy and paste with visual block mode

Visual block mode is activated with `ctrl-v`. Using `j` to select the entire block, you can then 'yank' it with `y`, then paste with `p`. You can repeat the paste operation as many times as you like with the `.` (dot) command, and if you go too far, you can pull it back with the `u` (undo) command.

### Duplicating lines

Sometimes the quickest way to create a new line of content is to copy a neighbouring line  using it as a starting point. You can quickly duplicate a line in Vim by issuing the command `Yp`. This places the cursor on the line below where you started. If you want to put the new line above where the cursor started, you could instead use `YP`.

### Search and replace within a visual selection

Vim lets you define a visual selection, then perform search and replace only on the selected range of lines. It's tempting to think that in visual block mode, a substitution command such as this:

    :s/_/ /g

would operate only on the selected block. But Vim considers the range to include entire lines, so the search and replace operation is not limited to the visual block.

The trick here is to modify the search pattern with the flag `\%V`. This tells Vim to match only within the visual selection. Running this substitution has the desired effect:

    :s/\%V_/ /g


### further reading ###

* [`:help \%V`][match_visual]
* [ASCII art generator][ascii_gen]
* [Vimcasts.org logo in ASCII format][ascii]

[logo]: http://vimcasts.s3.amazonaws.com/posters/vimcasts.png
[ascii]: http://vimcasts.org/episodes/creating-the-vimcasts-logo-as-ascii-art/vimcasts.txt
[match_visual]: http://vimdoc.sourceforge.net/htmldoc/pattern.html#/\%V
[ascii_gen]: http://patorjk.com/software/taag/
