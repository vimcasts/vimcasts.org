In TextMate, the commands in question can be found in the "Text" menu under "Move selection". I find the description "move line up" rather bland. The motion reminds me of an air bubble moving through a glass tube of liquid, so I prefer to call this feature "text bubbling". Vim doesn't have text bubbling built in, but we can easily replicate it by chaining together a few primitive commands. 

Bubbling a single line
----------------------

Lets start by moving the current line down a step. This can be done with the sequence of commands:

    ddp

* dd - deletes the current line, and stores it in the default register
* p  - pastes from the default register into the line below the cursor

To move the current line up a step, you begin in the same fashion with 'dd'. You might think that shift-P would place the deleted line above where it had been, but the cursor moves down to the line below where it was, and shift-P merely puts the text back where it started. So we need an extra command to move up a line before pasting the text. The full sequence of commands goes:

    ddkP
    "dee-dee-kay-shift-pee"

Typing a 3 or 4 letter command feels a bit arduous, so lets map these in a similar fashion to the TextMate commands. 

[MacVim comes ready bound with mappings for the ctrl+cmd+cursor key, so rather than using the exact same key commands as TextMate, I'm going to use control+cursor keys instead.]

Put the following in your .vimrc file:

    " Bubble current line
    nmap <C-Down> ddp
    nmap <C-Up> ddkP

With these mappings in place, I can bubble the current line up and down just by holding the control key and pressing the up and down arrow keys. 

Bubbling multiple lines
-----------------------

Text bubbling is most useful when used on multiple lines. To replicate this, we're going to have to create a similar mapping for visual mode. First, lets step through the primitive commands one by one.

I'll begin by enabling visual line mode, and selecting several lines. Then I'm going to cut these out with the `x` key, and paste them below the cursor position with the `p` key. The text that was selected has now moved down by one line, but we're only halfway there. Ideally, the mapping should finish as it started: with visual mode enabled, and the same lines of text selected.

You may already know that you can reselect the text from the last visual selection with the command `gv`. But in this case, it doesn't achieve the desired result. It looks as though the selection is addressed by line numbers, and since we've just cut and pasted our selection it can't be found at the old address.

Fortunately, we can select the text we want by using marks. Each time you make an edit, whether it is by typing text in insert mode or by pasting something into the document, Vim automatically marks the beginning and end of the edit. You can jump to either of these marks using the commands:

    `[
    "backtick-open-sqare-bracket"

to go to the beginning, or

    `]
    "backtick-close-sqare-bracket"

to go to the end.

So, to reselect the portion of text that was just pasted, I can run the commands:

    `[V`]
    "backtick-open-sqare-bracket, shift-V, backtick-close-sqare-bracket"

Now we have everything that we need to create a visual mode mapping for bubbling text. So I'll add a couple more lines to my .vimrc:

    " Bubble multiple lines
    vmap <C-Down> xp`[V`]
    vmap <C-Up> xkP`[V`]

With these mappings in place, I can bubble a visual selection up and down just by holding the control key and pressing the up and down arrow keys. 

Edge Cases
----------

These mappings have a flaw which is only apparent when you use them at the boundaries of a document. For example, if I try and move the bottom line up once, instead it moves up by two lines. Remember that these mappings are blind, they just replay a series of keystrokes, without any understanding of context.

A better solution is available if you install Tim Pope's 'unimpaired' plugin. This provides lots of useful commands, all of which are mapped to the square bracket keys in addition to one other letter. The commands that I want to focus on here are called 'exchange'. These work just like the bubble selection commands I've been talking about, except that they handle edge cases better. Instead of doing something weird, a warning message is issued, saying: "Invalid address".

If you have the unimpaired plugin installed, then you can use the "square bracket e" commands to bubble text up and down. But if you are used to the TextMate key commands, you could always recreate those mappings and hook into the commands from unimpaired.

Whether you use the default mappings, or create your own, unimpaired brings an added bonus: bubble movement can now accept a count. So I can make a visual selection, then press `5 ctrl-Up`, and the text moves up five lines.
