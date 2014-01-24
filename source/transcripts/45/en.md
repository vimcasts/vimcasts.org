## Strategy #1 - Substitute across all files
In this directory we've got 5 files. Let's open them up - here I'm using the `-o` flag (dash oh), which causes Vim to create a split window for each file specified:

    vim -o *.txt

Each buffer contains just a single line of text, so we can see everything at once. We're going to be using `:argdo` to run Ex commands across each of these buffers, so before we do anything, let's ensure that the 'hidden' option is enabled:

    :set hidden

Refer to Vimcast #6 if you're unsure what this setting does.

If I search for /Vimcasts, you'll see that it appears in 4 out of these 5 buffers.

    /Vimcasts

But only one of them uses the correct domain name:

    /Vimcast\.org

The others incorrectly use the .com TLD:

    /Vimcasts\.com

So let's fix that!

I'll just modify the pattern by adding `\zs` (backslash-zed-ess), which crops the pattern to only match the letters C, O, M:

    /Vimcasts\.\zscom

Now we can simply substitute 'com' with 'org':

    :%s/Vimcasts\.\zscom/org/g

Of course, the substitute command only acts on the current buffer. To make it run on all buffers, we could combine the `:substitute` command with `:argdo`. Note that I've added the `e` flag to the substitute command, which prevents the error message 'no match found':

    :argdo %s/Vimcasts\.\zscom/org/ge

In this case, we could just as well use `:bufdo` or even `:windo`, both of which would have the same effect.

If I search for the .org domain name, you should see that the change has been applied to all buffers.

    :first
    /Vimcasts\.org

Having made our substitution, we could then use the `:update` command to save our changes:

    :argdo update

[don't run the update command. Instead, run :argdo :edit! behind the scenes]

### Recap

Let's have a look at what we just did.

    :args *.txt     (or `vim *.txt`)
    :argdo %s//replacement/ge
    :argdo update

We start by populating the arglist with the set of all files that we'd like to change. In our case, we populated the arglist as we launched Vim, but we could just as well do it using the `:args` command.

Next, we ran the `substitute` command with `argdo`. Effectively, this is equivalent to running the substutute command once for each item in the arglist. In some buffers, this has an affect, while buffers that don't match the pattern are left untouched.

Finally, we run the `update` command with `argdo`. Even though this command is executed in all buffers, it only actually writes the buffer to disc if it has been changed.

For this demo, we're dealing with a small number of files. But suppose that we were working on a large codebase. It's easy to imagine a scenario where the substitute command would execute in hundreds of files without changing them. It's a scattershot approach, that seems kind of wasteful.

## Strategy 2: Find then replace

Let's consider an alternative workflow:

1. as before, we'll begin by setting up the arglist to contain all of the files in the project
2. then we'll find all of the files that contain a match
3. and run the substitute command *only in those files that contain a match*

Once again, we'll start off by setting the arglist to contain all of the files in the project:

    :args *.txt

Next we want to find all of the buffers that contain a match. We can do that using `:vimgrep`:

    :vimgrep /Vimcasts\.\zscom/g ##

That populates the quickfix list with all matches for the specified pattern. Note that the prompt indicates that there are 3 records in the quickfix list.

Here's the tricky part - we want to be able to execute the substitute command in each of the buffers listed in the quickfix list. Unfortunately, Vim doesn't provide a built-in command for this.  I have this tiny snippet of Vimscript in my `vimrc` file.

    :tabnew ~/.vimrc
    /Qargs
    zt

If I run the custom `:Qargs` command, it will set the arglist to contain each of the files referenced in the quickfix list. In this case, it's just as though the arglist had been pruned of the buffers that don't contain a match.

If we inspect the arglist, we'll find that it currently contains 5 buffers:

    :args
    [about.txt] itunes.txt rss.txt twitter.txt workshops.txt

Then if we run the custom Qargs command, the arglist is reduced to contain only the three files that contained a match for our pattern:

    :Qargs
    :args
    [about.txt] rss.txt workshops.txt

Now we can run the `substitute` command with `argdo` just as before:

    :argdo %s/Vimcasts\.\zscom/org/ge

And finish off by saving the changes to disc:

    :argdo write

### Recap

Let's have a look at what we just did.

    :args *.txt
    :vimgrep /Vimcasts\.\zscom/g ##
    :Qargs
    :argdo %s/Vimcasts\.\zscom/org/g
    :argdo write

We start by populating the arglist with all the files in the project. Then we look inside those files for all occurrences of the pattern. The `:Qargs` command prunes the arglist, removing any buffers that don't contain a match for the specified pattern. Then we run the substitute command across the arglist, and save the changes.

### Missing feature: :cdo

It's a pity that Vim doesn't provide a built-in way of running the substitute command across all the files in the quickfix list. Vim already has argdo, bufdo, windo and tabdo; It feels as though there should also be a `:quickfixdo` command.

If such a command existed, it would mean we could remove the `Qargs` step, producing a simpler workflow:

    :args *.txt
    :vimgrep /<C-r>// ##
    :cdo %s//replacement/ge
    :cdo write

Here, it's clear that one step is concerned with *finding* matches, while the another is concerned with *replacing* them with something else.

Check the shownotes for links to a couple of other Vimscript solutions that make this workflow possible.
