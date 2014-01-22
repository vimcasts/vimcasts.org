Converting HAML to ERB with Vim macros
======================================

Intro
=====

HAML and ERB are two commonly used ruby templating languages. You may have a strong preference for one or the other, but it's not always up to you which one you use. I was recently asked to convert several HAML files to ERB format. In this episode, I will demonstrate a couple of Vim macros that helped make short work of the task.

Commercial
----------

You can now show your support for Vimcasts using Flattr - a social micropayment service. If you enjoy this episode, please flattr me by clicking the button on the shownotes page. Your donation can ensure that Vimcasts remains free to all.

Setup
=====

When I open an ERB file, Vim detects the filetype from the file extension and sets the auto indentation accordingly. In this case, I have a HAML file with the ERB extension. This is going to confuse Vim's automatic indentation, so I shall begin by switching it off:

    :set indentexpr=

[Also, enable search highlighting.

    :set hlsearch

]

Single line ruby expressions
----------------------------

In HAML, there are basically two different ways of evaluating ruby. The lines beginning with a minus sign evalute the code silently, whereas those beginning with an equals sign will output the result of the code.

In ERB we have the same two concepts, except that the whole expression is wrapped in angle-brackets with percent symbols. 

For a one-liner such as this, the conversion from HAML to ERB is straightforward. Pressing shift-I moves my cursor to the first non-blank character and enters insert mode. I type the opening angle bracket delimiters, then press the escape key to leave insert mode. Shift-A puts me in insert mode the end of the line, where I enter a space followed by the closing delimiter. I then hit escape again to leave insert mode.

It's nothing too arduous, but if you have to do this over and over you can save yourself some time by recording a macro.

I'll repeat the edit, but this time I shall record my keystrokes. 

With my cursor on the next line that I want to change, I begin recording into the 'P' register by pressing `qp`. Once again, shift-I to insert the opening delimiter; shift-A to append the closing delimiter, and when I'm done, I hit the `q` key again to stop recording.

I'm going to search for the pattern of an equals sign at the beginning of a line, with zero or more leading whitespace characters in front of it. 

    /^\s\+=

This takes me straight to my next match. From here, I can replay the macro by pressing `@p`. Remember that the macro was recorded into the 'p' register.

Pressing the `n` key takes me to the next match for my search pattern. I can then replay my macro by hitting the `@` key twice. This is just a shorthand to replay the macro that was most recently played.

So by typing the sequence `n@@` again and again, I can rapidly apply this conversion throughout the file.

Multiline ruby expressions
==========================

HAML somewhat resembles Python in that it uses significant whitespace. Whereas ERB looks more like ruby because it uses the `end` keyword. 

To convert this HAML file into ERB it will be necessary to insert `end` keywords in a few places. Once again, I'm going to use a macro to record my keystrokes so that this conversion can be replayed. 

To begin with, I place my cursor on the first line of the block, then enter visual line mode by pressing shift-V. I then move my cursor down until I've selected the entire block. The `end` keyword will be inserted on the line after the selection.

Having visually selected the range that I want to wrap, I am ready to begin recording my macro. I press `qo`, to save my keystrokes into the 'o' register.

I want to keep track of the top and bottom of my current selection, and to do this I'm going to use a couple of marks. My cursor is currently at the bottom of the selection, so I press `mb` to *mark* the *bottom* of my range.

The `o` key moves my cursor to the opposite end of the selection, and here I press `mt` to *mark* the *top* of the range. Having saved those two positions, I press escape to exit visual mode.

The line at the top of the block needs to be wrapped in ERB delimiters. Even though I am currently recording a macro, there is nothing to stop me from playing back another macro. So if I run `@p` it will play back the macro that I recorded earlier.

Now, I want to insert the `end` keyword. Remember that I saved the position of the bottom of the block with the 'b' mark, so I can jump back there by pressing 'single-quote-b'. The `o` key opens a new line underneath, then I type the `end` keyword and hit escape to leave insert mode.

This is valid ERB, but it would be nice to tidy up the formatting whilst I'm at it. I'm going to do this by simply copying the indentation at the beginning of the block, and pasting in front of the last line of the block. 

I can jump back up to the top mark with 'single-quote-t'. Then hit `0` zero to get to the beginning of the line. `v^h` 'v-caret-h' visually selects the leading whitespace characters. I'm going to yank these into the 'n' register ('n' is for 'indentation') by pressing 'doublequote-n-y'.

I jump to the end of the block with `'bj` 'single-quote-b-j', then move to the beginning of the line by pressing `0` zero, and insert the indentation from the 'n' register by pressing `"nP` 'doublequote-n-shift-P'. 

I'm happy with that, so I'll press `q` to stop recording my keystrokes.

Now, if I manually select a block of code in visual mode, I can quickly convert it to ERB by replaying the macro that I just recorded. 

Limitations
-----------

Don't forget that a macro is simply a recording of commands which you can play back. It doesn't follow any logic, so in some situations the result of running a macro may be surprising.

In this example, the macro expects you to make your selection from the top down. If you make a visual selection by starting at the bottom of a block, then the macro will invert the marks for top and bottom, and the result will look broken. To fix this:

    ugvo@o

undo the change, reselect the last visual block, ensure that the cursor is positioned at the bottom of the selection, and replay the macro. No big deal.

Coda
====

The information in this video is summarized in the accompanying shownotes. 

If you have any questions, requests or recommendations, or if you would be interested in sponsoring vimcasts, then you can contact me at DREW AT VIMCASTS DOT ORG.

Vimcasts is supported by Xeriom networks. If you need to build a reliable, scalable network that can support your growing business needs, then get in touch with xeriom networks, and be sure to say you heard about them here.
