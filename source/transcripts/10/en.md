## INTRO ##

This week, I'm going to do something a little bit different. Instead of focussing on a particular feature, I'm going to show a few tips and tricks used during an editing session. 

If you take a look at the source code for Vimcasts.org, you'll see that there is a bit of ASCII art hidden in a comment. This was generated using an online tool, but I've made some tweaks to make it look more like the logo for Vimcasts.org.

## Comparison ##

At the top of this file, I have the original text, as copied from the online tool. At the bottom of the file is the example copied from the source code of Vimcasts.org.

## Convert leading spaces to underscores ##

The first modification I want to make is to replace the leading whitespace with underscores. I'm going to do this by defining a visual selection, then replacing each character in that selection with an underscore.

Run:

    0vw
    r_

I can see that I'm going to have to issue this combination of commands several times, so I could save myself a few keystrokes by recording a macro. 

    qavwr_jq

You can begin and end recording a macro by pressing the `q` key. The first key you press after `q` specifies the register where the macro will be recorded. You can use any lowercase letter, or a number. Here, I'm saving the macro to register 'a'. I then issue the command: `vw` to make the selection, `r_` to transform it, then I finish by moving the cursor down to the next line. Pressing q again finishes the recording.

I can now replay the macro by pressing the `@` 'at' key, followed by the register that it was saved to. In this case, 'at-a' replays the recording

    @a

I can also prepend a count and it will replay the macro the specified number of times. For example:

    8@a

And presto! It's done.


## Indent further ##

At the moment, the first letter of each block is aligned vertically, but I want them to be aligned following the diagonal. I'm going to fix this by copying and pasting with visual block mode. 

Control-v puts Vim into visual block mode. I move the cursor down with the j key, until I've selected the entire block:

    ctrl-v
    jjj...jjj

then press y to yank the selection:

    y

I can now paste this column under the current cursor position with the p key, which indents the entire block:

    p

I can repeat with the dot key, and if I go too far, I just undo with the u key:

    .
    u

## Add a wrapper line above and below each block ##

At the moment, the capital letters occupy the full height of each block. I want to add a line of underscores at the top and bottom of each block. 

To add a line above, I'm going to duplicate this line, then replace each character wiht an underscore:

    YP
    Vr_
    x

To add a line below:

    Yp
    Vr_
    i_<esc>


## Substitute '_' with ' ' in .org ##

Finally, I want to remove the underscores from the 'dot-org' part of the logo. 

Vim lets you define a visual selection, then perform search and replace only on the selected range of lines. Here, I make a selection using visual block mode, which is activated with control-v.

    ctrl-v
    $jj...jj

It would seem reasonable to expect that running a substitution on this range would affect only the selection. 

    :s/_/ /g

But Vim considers the range to include entire lines from the selection. So this does not acheive the desired effect.

The trick here is to modify the search pattern with the flag 'backslash-percent-capital-V'. This tells Vim to match only within the visual selection.

Running this substitution has the desired effect:

    :s/\%V_/ /g

## Continuation ##

The remaining edits reuse techniques already covered. So I shall continue without further commentary.

If you want to practice these commands, you can find a link to this file in its original state in the shownotes.