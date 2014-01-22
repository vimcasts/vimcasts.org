Let's work through the same example we used in the previous lesson:

    collection = getCollection();
    process(obstacleToBeRemoved, target);

`"ayiw` "double-quote A wye-eye-doubleyou" copies the current word into named register A:

    :reg "a
    "" collection
    "a collection

`diw` cuts the current word, writing it to the default register.

    :reg "a
    "" obstacleToBeRemoved
    "a collection

At this point, if we use the `P` "big P" command without specifying a register, Vim pastes the text that we just deleted.

[undo the change]

But if we prefix the `P` "big P" command with `"a` "doublequote A", then it pastes the text that we saved to that register.

---

Vim's named registers have an interesting property: not only can we write to them, but we can also append to them. Take this code sample, which is littered with `TODO` comments:

    // TODO: fix this shit
    // ...
    // TODO: refactor
    // ...
    // TODO: extract this into a class

I'd like to yank each of those lines into the same register. The first time, I'll write to register A in the usual fashion: `"ayy` "doublequote small A wye wye". As you'd expect, this sets the contents of register a:

    :reg a
    "a //TODO: fix this shit

I'll jump to the next occurrence, and this time I'm going to specify the register using an uppercase A: `"Ayy`. Inspecting the contents of the register, you'll see that the current line was appended to register A, instead of overwriting the existing contents:

    :reg a
    "a //TODO: fix this shit^J //TODO: fix this shit refactor

The ctrl-j character stands for newline in this case.

We could go through the rest of this  document, using the same command to append each TODO line to register a. But it worries me that I might accidentally use a lowercase letter, which would overwrite the register. I'd be back to square one.

Alternatively, I could use the yank Ex command:

    :yank A

I could still accidentally type a lowercase 'a', but this way lets me see which keys I've typed. I get the opportunity to correct any typing errors before hitting enter.

Let's check if it worked:

    :reg a
    "a //TODO: fix this shit^J //TODO: refactor^J // TODO: extract this into a class 

Sure enough, the Ex command has appended the current line to register a.

---

Let's finish off with a neat trick. First, we can clear the contents of register 'a' by running `qaq`. See? The register has been reset:

    :reg a
    "a 

Now let's use the `:global` command to execute the `:yank` command on every line that contains the word TODO:

    :g/TODO/y A

Register 'a' now contains the text of each TODO. Pretty neat!

