[prep: :set nonumber foldcolumn=1]

Here's the brief: we'll copy this line (#9), and place a duplicate of it here. It's a simple task, but we'll see that there are severeal different ways of getting the job done.

## Linewise move, yank, linewise move, put

Let's start with a naïve attempt. We'll move our cursor linewise to the bit we want to copy, then yank that line:

    kkkkkkk
    yy

Then we'll reverse back to where we started, and paste the line that we yanked:

    jjjjjjj
    p

If you care about using Vim well, this should make you wince.

Let's look at those keystrokes. It should be immediately striking that most of these keystrokes are simply moving the cursor, one line at a time. We can do better than this.

## Line jump, yank, snapback, put

Let's undo that change, and start again. I'm going to turn on line numbers, by running:

    :set number

Now we can see the number of the line that we want to copy: it's line 9. We can get there in a single move: by pressing 9G (nine-shift-gee), to *go to the specified line*. As before, we'll yank the current line:

    9G
    yy

Now we could get back to where we came from by pressing 16G (sixteen-shift-gee), but there's a better way. You see, the goto line motion creates a record in Vim's jumplist. That means that we can snap back to where we came from using the `ctrl-o` command. 

    <C-o>
    p

Now that our cursor is in the correct position, we can paste the line that we yanked. Job done!

Comparing the last two solutions, we can see that jumping to a linenumber can save a lot of keystrokes compared to moving the cursor one line at a time. Also, using the jumplist to snapback to where we came from means that we only have to look up one line number, instead of two. That's not a great saving in terms of keystrokes, but it is a saving in terms of brain-cycles.

## Remote yank, put

Vim has another command for jumping to a specified line number. Instead of pressing nine-shift-gee, we could press colon-nine-enter:

    :9

This is an Ex command, so the specified number is treated as an address. The result in this case is that the cursor is moved to the specified line number.

But watch this. I'll just move my cursor back to where it started, then I'll run (colon-nine-yank):

    :9yank

This yanks the specified line, and the cool thing about this command is that it doesn't move the cursor. We've got it right where we want it, so now we can paste the line using the Normal mode `p` command.

Altogether, that sequence of commands can be reduced to:

    :9y
    p

Our cursor never moves, so this technique allows us to cut the number of steps in half.

Pretty neat! But we can still do better.

## Copy

Vim has another Ex command which combines the yank and put steps into one. It's called :copy:

    :help :copy

It accepts a range, and an address. The range is the line (or lines) that you want to copy. The address is the destination where you want the duplicated line to appear.

In our example, we want to copy line 9, and paste the duplicate below line 16. That translates to:

    :9copy16

Bang! Job done, in one move.

But this is the long-hand form. We can shave off a few more keystrokes. First of all, the copy command has a one-letter alias (colon-tee):

    :help :t

As a mnemonic, I think of it as *copy TO*. Using that, we can cut this down to:

    :9t16

There's some redundant information in this command: can you spot it?

[pause]

Our cursor is positioned on line 16, so why should we have to look up that address and type the number into our command line? In Ex commands, where an address is expected, you can always use the dot symbol as a shorthand for the current line. So we can reduce this to:

    :9t.

That reads as: take line 9, copy to, below the current line. That's a lot of information packed into three characters! And it's about as far as we can compress this. 
 
## :set relativenumber

You might be thinking: 'how can I use this with relativenumber?' Well, let's see. I'll enable the relativenumber setting:

    :set relativenumber

With this enabled, Vim shows line numbers relative to the cursor position. 

The line that we want to duplicate is now labelled seven, which means it's seven lines above the current cursor position.

If we prefix our address with a minus or plus sign, then Vim will calculate the line number as an offset against the current line. So we can simply say:

    :-7t.

And that does the job. So you can use the `:t` command whether you use absolute or relative line numbering.
