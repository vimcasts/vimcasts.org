## Evaluating simple maths expressions

This document contains a few simple maths problems:

    21 * 2   = 
    12 * 12  = 
    156 / 12 = 

We're going to use the expression register to calculate the results and insert them into the document. I'll run through this three times, so don't worry if you don't catch it the first time.

I'll switch to insert mode then drop into the expression register, which moves the focus to the command line. Then I'll type out the expression that I want to calculate: 21 times 2, and hit enter. Boom! Vim calculates the result, and inserts it into the document.

I'll do that again, at a slower pace this time...

In Insert mode, watch what happens when I press "control-R equals": the cursor is replaced with a double-quote symbol, which acts as a placeholder, and the focus moves to the command-line. Usually, the commandline uses a colon as the prompt, which lets us run an Ex command. But this time the prompt is an equals sign, which tells us we're in the expression register. I type out the sum that I want to calculate: twelve times twelve. Pressing enter tells Vim to evaluate this as a Vimscript expression, and to insert the result into the document at the cursor location, which is indicated by the double-quote placeholder.

Let's try another approach: this time I'm going to select the text of the expression that I want to evaluate, and copy it. I'll switch to insert mode and dial up the expression register, which drops me into commandline mode. The "control-R" command works here too, so I can paste the text that I just yanked by pressing "control-R double-quote". When I press enter, Vim evaluates the expression and inserts the result into the document. That's pretty cool!

### Explanation

In general, we can think of Vim's registers as being variables that hold a string of text, but the expression register is different. This register behaves like a scratchpad, that lets us evaluate Vimscript code. If the return value is a string, or if it can be coerced to a string, then Vim will use the result just as though it had been retrieved from any other register.

### Mapping demo

The expression register can be really useful in creating mappings. Suppose that we're faced with a whole page of calculations, and we have to insert the result for each one. We could speed things up by creating a mapping:

    nnoremap Q 0yt=A<C-r>=<C-r>"<CR><Esc>

Now, when I press `Q` shift-Q, Vim yanks the text from the start of the line up to (but not including) the equals sign, then pastes that text into the expression register and appends the result at the end of the line. Now we can do a unit of work with a single keystroke.

Here's one final trick. I'll select the range of lines that I want to change, then use the `:normal` Ex command to execute the mapping that we just created on each selected line.

    :normal Q

Boom! Job done.
