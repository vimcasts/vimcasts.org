I want to change this snippet of code so that the `obstacleToBeRemoved` is replaced with the word `collection`.

    collection = getCollection();
    process(obstacleToBeRemoved, target);

Rather than type out the word from scratch, we'll do the lazy thing: yanking the word `collection` from the previous line then pasting where we need it.

`yiw` "wye-eye-double-you" yanks the current word into Vim's default register. To make room for the paste operation, we'll delete the `obstacleToBeRemoved` text with the `diw` command. Now we want to put the text that we copied *in front of* the cursor position, so we'll use the `P` "big P" command.

What happened there? Instead of using the text that we yanked, Vim has pasted the text that we deleted.

If that seems surprising to you, it might be that Vim's terminology is tripping you up. You see, Vim's delete command is actually more like a cut operation. Not only does it remove text from the document, it copies it into the default register.

    Vim         Everything else
    put         paste
    yank        copy
    delete      cut

From now on, I'm going to avoid Vim's jargon, preferring instead to use the more standard *cut, copy and paste* terminology.

Check this out. We can inspect the contents of the default register by running the Ex command "reg doublequote":

    :reg "
    "" obstacleToBeRemoved

It contains the text `obstacleToBeRemoved`, because the `diw` operation cut that text from the document, writing it to the default register. 

Now get this: Vim has a special register that always contains the last text that was yanked. It's addressed by "double-quote zero":

    :reg 0
    "0 collection

I call it the *yank register*.

    uuu - revert changes

Let's back up and go through each of those steps again, this time keeping an eye on the contents of the default and yank registers.

After running `yiw` on the word `collection`, both registers contains that word:

    :reg "0
    "" collection
    "0 collection

After running `diw` on the word `obstacleToBeRemoved`, the default register has been updated, but the yank register is unchanged:

    :reg "0
    "" obstacleToBeRemoved
    "0 collection

Now we can insert the text that we yanked by prefixing the paste command with "double-quote zero": `"0P`.

That puts the contents of the yank register, which does the trick!

---

Comparing Vim's jargon with the more standard cut, copy, paste terminology might raise a question: if Vim's delete command is really a cut operation, does Vim have anything equivalent to a true deletion?

    Standard terminology   Vim's jargon
    paste                  put
    copy                   yank
    cut                    delete
    delete                 ???

The answer is slightly oddball: writing to the 'blackhole register' performs a true deletion.

The 'blackhole register' is addressed by doublequote underscore:

    :help quote_

Quick demo: running `yiw` populates both default and yank registers:

    :reg "0
    "" collection
    "0 collection

Running `"_diw` "double-quote-underscore dee eye doubleyou" deletes the text, leaving the default register unchanged:

    :reg "0
    "" obstacleToBeRemoved
    "0 collection

Now we can go ahead and paste from the default register, using `P` "big P" without having to prefix any register.

---

### Outro

It's a common cause of frustration for Vim users: trying to paste something you previously yanked, only to find that the default register has been clobbered by a cut operation. The yank register is one of my favourite ways of avoiding this pitfall.

We'll look at alternative approaches in the next couple of episodes.
