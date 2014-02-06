# Creating mappings that accept a count

Lots of Vim's built-in Normal mode commands can be executed multiple times by prefixing them with a count. User-defined Normal mode mappings don't usually handle counts the way you might like them to. We'll explore a couple of techniques for making your custom mappings respond predictably to a count.

Here's a task that I find myself performing often: I'll search for the word 'Intro', change it to something else, then repeat the same edit a handful of times by pressing `n.` (N-dot) again and again. That's two keystrokes per change. What if we could collapse that down to a single keystroke?

I don't like the built-in behaviour of the `Q` (shift-Q) command, so I like to map it to something more useful. Let's set up a Normal mode mapping so that pressing shift-Q executes N-dot:

    nnoremap Q n.

I'll write that file, then source it. 
Now let's try out our mapping.
I'll search for the word 'Welcome', then change it back to 'Intro'. Now each time that I press shift-Q, Vim jumps to the next match and repeats the last change.

I'll just undo each of those changes and we'll try something different.

I've got search-highlighting enabled, and I can tell at a glance that I'm going to want to repeat this change FOUR times in total. Many of Vim's commands can be prefixed with a count. Let's try using a count of FOUR with our custom mapping.

See what's happened? The `n` command has been repeated FOUR times, but the dot command was only executed one time. It would be nice if we could fix our custom mapping so that the count applied to everything, not just the very next command.

Here's one way of making this work:

    nnoremap Q @='n.'<CR>

I'll write the file, then source it, now let's try our revised mapping. I'll repeat my search for 'Welcome', change it to 'Intro', then press `3Q`. Sure enough, the count has caused the change to be applied to the next 3 occurrences.

So how does it work? The `@` key tells Vim to execute a macro. Rather than using a named register, we use the expression register, which let's us specify the contents in place. The characters inside of the quotes are interpreted as keystrokes, and the carriage return enters the string into the expression register. When we execute this with a count, it applies to the entire macro, not just the very next command.

It's a pretty neat trick, but it can look a bit cryptic inside a vimrc file! Here's an alternative method, which I find slightly easier on the eye:

    nnoremap Q :normal n.<CR>

This uses the `:normal` Ex command to execute n-dot. I'll write and source the file, and quickly demonstrate... Again, this mapping works fine with a count.

As an exercise, why don't you go through any Normal mode mappings you've got in your vimrc and ask yourself: "could this be improved by being made to accept a count?" If the answer is yes, then I suggest that you modify the mapping to use one of these patterns.
