Let's work through the same example we used in the previous lessons:

    collection = getCollection();
    process(obstacleToBeRemoved, target);
    apply(obstacleToBeRemoved, target);

Once again, we'll replace `obstacleToBeRemoved` with the word `collection` by copying the word from the previous line and pasting where we need it.

`yiw` "wye-eye-doubleyou" copies the current word into the default register and the yank register:  

    :reg "0
    "" collection
    "0 collection

Now watch this: I'll use `viw` "vee-eye-doubleyou" to select the `obstacleToBeRemoved`. In Visual mode, the `p` command will get the text from default register and use it to overwrite the selection.

That's a pretty smooth workflow. In our previous attempts to solve this, we've always deleted the `obstacleToBeRemoved` before pasting its replacement. The visual mode put command combines both of these steps into one. Note that this command has a side-effect: the text that was originally selected is copied to the default register:

    :reg "0
    "" obstacleToBeRemoved
    "0 collection

If we attempt to use the same technique to overwrite a second `obstacleToBeRemoved`, it doesn't work.

    viwp

That's because the `p` command gets its text from the default register, which now contains the word `obstacleToBeRemoved`. However, the yank register still contains the text that we want to use. We can get at it by prefixing the `p` command with the yank register:

    viw"0p

---

Think about it this way: when we use the `p` command in visual mode, the selected text and the default register swap places. That turns out to be quite handy if you want to swap the order of two items of text.

Take this example:

    execute(second, first)

We'll switch the two arguments to read: first then second.

To begin with, we'll yank the word `second`:

    yiw

That writes the word `second` into the default and yank registers:

    :reg "0
    "" second
    "0 second

Then we'll select the word `first` and use `p` to overwrite it with the text from the default register.

    viwp

In addition to changing the document, that command writes the word `first` into the default register:

    :reg "0
    "" first
    "0 second

Quick tip: we can use `#` "hash" key to search backwards for the word under the cursor, which gets us back to the first argument. Select the word, and paste:

    viwp

That overwrites the selection with the contents of the default register. The end result is that we've swapped the order of the two arguments. That's pretty nifty!
