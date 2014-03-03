I want to change the order of the words 'pepper' and 'salt' in this excerpt:

    Can you pass the pepper and salt?

Here's one possible workflow:

We'll start by yanking the word 'pepper'.
Then we'll select the word 'salt' and use the Visual mode put command.
That overwrites the selection, and saves the word 'salt' to the default register.
Now if I select the word 'pepper' and use the `p` command, it completes the job.

I ran through that pretty quickly, but if you want a more detailed explanation check out Vimcasts episode 54.

It's a neat workflow, but I feel that there's room for some improvement.
If we want to revert to the previous order of words then we have to press undo twice, because we made two discreet changes.

For an alternative approach, check out exchange, by Tom McDonald.
This is a little gem of a plugin!
It provides one extra operation: which is mapped to `cx` by default.

Let's use this same example to demonstrate:

I'll visually select the word 'pepper' then press `cx`
That doesn't change the document, it just marks the selected text
Next, I'll select the word 'salt', and when I press `cx` the two words are exchanged at once.

One pleasing consequence to this approach is that I can revert the change by pressing undo one time.

The `cx` operator can also accept a motion:

    :h cx

I prefer to use it in this fashion, because it lets me use the dot command to repeat the `cx` operator using the same motion.
Watch: with my cursor on the word 'pepper' I'll press `cxiw`, which marks the current word for exchange. 
It also sets things up so that when I invoke the dot command, it's equivalent to typing `cxiw`.
I'll move my cursor to the word 'salt'.
Press dot one time...
And the two words are exchanged!

Of course, the `cx` operator works fine with other motions and text objects too.
Suppose that we want to swap the text inside parentheses on these two adjacent lines:

    let blockstartcol = virtcol([start[1], start[2]])
    let blockendcol = virtcol([end[1], end[2]])

We'll use `cxi)` "see-ex-eye-paren" to mark the text inside the first set of parens.
Place the cursor in between the next set of parens and use the dot command.
Boom! The arguments have been exchanged.

As you might expect, we can also make the exchange operator act on entire lines by pressing `cxx`. 

[pause]

The `cx` operator is unlike any other, because you have to invoke it twice to change the document. If you happen to invoke the operator by mistake, then you can use the `cxc` command to clear the marked text.
