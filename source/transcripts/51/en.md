### Toggling characters

When I'm typing, I frequently make this sort of error: I hit all the right keys, but in the wrong order.

    Vimcasts is bakc!

It's easily fixed. I'll place my cursor on the first of the two characters that I want to exchange, then press `xp`.

    Vimcasts is back!

* `2u` again, but slowly.
* `x` cuts a single character, copying it into Vim's default register.
* `p` gets the contents of the default register and puts that text into the document after the cursor position.

Even though `x` and `p` are two discrete commands, you can think of `xp` as meaning *toggle characters*, as though it were a single command.

### Toggling lines

We can just as easily toggle the order of lines. Here's a list of upcoming Vimcast episodes:

    Default register operations
    Using named registers
    Meet the yank register

I'd like to swap the order of the 2nd and 3rd items. I'll put my cursor on the first of the lines I want to exchange, then press `ddp`:

    Simple operations using the default register
    Meet the yank register
    Using named registers

`dd` cuts the current line, copying it into Vim's default register. As before, `p` gets the contents of the default register and puts that text into the document after the cursor.

Just as `xp` can be thought of as *toggle characters* command, `ddp` can be thought of as *toggle lines*.

#### Charwise vs linewise

Between these two examples, there's a subtle difference in the behavior of the `p` command. In the first instance, the default register contained a characterwise region of text, so the `p` command put the text *after the current character*. In the second instance, the default register contained a linewise region, so the `p` command put the text *after the current line*. It doesn't matter if the cursor is on the first or last character of the line, and that's really convenient!

Watch what happens when I do a linewise cut-n-paste in a basic text editor. I'll select the entire line and cut it. Now the paste command works fine so long as my cursor is at the start of the line, but if my cursor is anywhere else then the result is messy!

### Duplicating lines

We can also use Vim's default register to quickly duplicate a line, by pressing `yyp`:

    Pasting text from Visual mode
    Pasting text from Visual mode

`yy` copies the line into the default register. `p` does the same as before, putting the text from the default register after the current line.

Just as `ddp` can be thought of as a *toggle lines* command, `yyp` can be thought of as a *duplicate line* command.

### Outro

Common operations such as these are made easy by Vim's *default register*, which is paradoxically called the 'unnamed register' in the documentation:

    :h quotequote

Vim has many more registers besides the default register. We'll learn more about them in the next episodes.
