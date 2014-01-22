Indentation is an effective way of structuring any document, be it code or markup. Being able to quickly increase or decrease the level of indentation is an essential feature of any text editor.

In Vim, this functionality is triggered using the angle bracket keys. There are a few ways that these can be used. 

In normal mode, if you press the angle bracket key twice, it will operate on the current line.

    >>    indent the current line
    <<    outdent the current line

You can make the command run on multiple lines by prepending a count. So `5>>` ('five-greater-than-greater-than) will indent five lines, starting with the current line.

If you go into visual mode, you can alter the indentation of all selected lines by pressing the angle bracket key just once.

Note that the indentation command causes the visual selection to be unselected. If you are coming to Vim from another editor, such as TextMate, this may seem a little bit odd. When I use the indentation command on a selection in TextMate, it leaves the selection intact, allowing me to run the command multiple times. And if I indent too far, I can just as easily run the outdent command to bring it back a level.

In Vim, the indentation command exits visual mode, so if you try to repeat the command, it won't operate on the same range of text. However, the `.` command repeats the last edit, and this allows you to quickly indent the same range of text by further step. If you go one step too far, you can reverse with the `u` command, which undoes the last edit.

You could easily create a mapping to make Vim behave in the same fashion as TextMate. The `gv` command reselects the last visual selection. If we map the command-square-bracket keys to Vim's angle bracket commands followed by `gv`, we can replicate the TextMate behaviour.

    vmap <D-[> <gv
    vmap <D-]> >gv


Auto indent
-----------

Vim also has an auto-indent command. This is applies indentation following a set of rules for the language of the file you are editing. 

The auto-indent command is triggered with the '=' key. This behaves in a similar fashion to the angle bracket keys:

* pressing the the equals key twice will act on the current line
* if you prepend a count, then double-pressing the equals key will act on the specified number of lines
* in visual mode, the equals key will apply to all selected lines

Indentation rules can be defined using Vimscript in an indent file for any language. You can see which indentation files come with Vim by exploring the 'vimruntime-slash-indent' directory:

    :edit $VIMRUNTIME/indent

If you work with a language which lacks an indent file, Vim will try and use the indentation rules from C. You can install indentation files for additional languages, or override the existing ones, by putting them in the 'dot-vim/indent' directory, in a file named after the language:

    ~/.vim/indent/language_name.vim

You can also tell Vim to reformat using an external program when you use the `=` command. This is done by setting the value of `equalprg` to the name of an external program, along with any arguments it should be passed. 

    :setlocal equalprg=tidy\ -utf8\ -indent\ -q\ -f\ /tmp/err

Check this episode's shownotes for further reading on this subject.

Motions
-------

All of the indentation commands can be triggered with a motion.

    >{motion}
    <{motion}
    ={motion}

To demonstrate this, I'm going to begin by flattening the indentation on this file. 

    ggVG
    <....

Now, I'll jump to the top of the file with `gg`, then run `=G` ('equals-shift-G). Shift-G is the motion to move to the end of a file, so this tells vim to apply the auto-format command to every line in the file. As you can see, the entire file has now been indented appropriately.

Some of Vim's motion commands are aware of the structure of your code, and can enable you to select multi-line blocks in just a couple of keystrokes. For example, in this javascript file, I can select every line inside this block with the command:

    vi} "V-I-curly-brace"

* v goes into visual mode
* "curly-brace" } says to use the curly braces as delimiters for the selection
* i specifies that the Inner text should be selected (i.e. not including the braces themselves)

Here, I am using visual mode just to illustrate which lines are selected by the "I-curly-brace" 'i}' motion. But remember that all of the indentation commands can receive a motion. So to fix the indentation in this example, we could simply go:

    =i}  "equals-I-curly-brace"

* the equals key runs auto-indent
* i} is the motion specifying the text within the curly braces

For more information on these smart motion commands, check the documentation: [by running]

    :help text-objects
