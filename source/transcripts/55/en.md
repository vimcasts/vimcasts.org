In the previous lesson, we replaced both occurrences of `obstacleToBeRemoved` with the word `collection` using Visual mode:

    collection = getCollection();
    process(obstacleToBeRemoved, target);
    apply(obstacleToBeRemoved, target);

Here's another way of doing it. Once again, we'll start by yanking the word `collection` (`yiw`). That sets the contents of the default and yank registers:

    :reg "0
    "" collection
    "0 collection

[search: /obst]

Now let's use the `ciw` "sea-eye-doubleyou" command to delete the `obstacleToBeRemoved` and switch to Insert mode. From Insert mode we can insert the contents of the yank register by pressing `<C-r>0` "control-are-zero". We're done with Insert mode now, so I'll press escape to return to Normal mode. 

The beauty of this approach is that we can jump to the next match with `n`, then repeat the last change with the dot command.

If we take a look at our registers:

    :reg "0
    "" obstacleToBeRemoved
    "0 collection

The yank register still contains the text that we yanked, but the default register contains the text that we removed using the `ciw` command. That's because the change command copies text into the default register before removing it from the document.

We used `<C-r>0` "control-are-zero" to paste the contents of the yank register from insert mode. 

    :h i_ctrl-r

We could use the same technique to paste the contents from any register. Vim's documentation for this command includes a handy summary of registers.

---

The same command works just as well at Vim's command line.
For example, suppose that want to try out this mapping from a vimrc file.
I'll just yank that line, then press colon to dial up the command line.
Now I can put the text from the yank register by pressing `<C-r>0`.
Presto!

---

The `<C-r>` command has a surprising limitation. To demonstrate, I'm going to attempt to solve the Vimgolf challenge [Words in parens][golf], which requires me to wrap each of these words in parens:

    one two
    three

Remember: this is Vimgolf, so we can't use the surround plugin!

Let's see if we can solve this using the dot command. I'll use `cw` to delete the first word and switch to insert mode. Then I'll type an opening paren, use `<C-r>"` "control-are-doublequote" to paste the default register, then type the closing paren and leave Insert mode. That looks ok, but watch this. I'll jump to the next word, and when I use the dot command, it reproduces the result of the last insertion. That's disappointing!

[undo the changes]

Let's try again, but this time we'll use a variation of the "control-r" command "control-are-control-oh":

    :h i_ctrl-r_ctrl-o

This one inserts the contents of the register, LITERALLY! Let's try using this command, while keeping everything else the same as before.

Now when I use the dot command, it uses the current value of the default register, producing a more dynamic result. That's good to know about!

[golf]: http://vimgolf.com/challenges/5192f96ad8df110002000002
