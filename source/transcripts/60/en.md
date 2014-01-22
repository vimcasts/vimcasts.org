Here I have a draft of the shownotes for a previous Vimcasts episode. Since publishing this episode, I've made a couple of changes in the Vimcasts CMS. Now I'd like to compare my local draft with the latest revision.

You may already know about the `vimdiff` command:

    man vimdiff

We can call this from the command line giving it two or more filenames. vimdiff launches Vim, creates a window for each specified file, and highlights the differences between them.

We have a slight problem here though: one of the text files we want to compare is contained in a text area on a webpage. Before we can use `vimdiff`, we'll have to put that text into a file. I'll do so by copying the contents of the text area to my clipboard, then saving it to a file:

    pbpaste > 45-shownotes-latest.md

I'm using the `pbpaste` command here, which is specific to os x.

Now we can run vimdiff:

    vimdiff 45-shownotes-draft.md 45-shownotes.md

That opens each of the specified files in its own split window, and highlights the bits that are different. I can jump forward and back between changes using the "square-bracket C" commands.

If I wanted to resolve these differences, I could use the `:diffput` and `:diffget` commands. Check out episodes 32 and 33 for a demonstration of how they work.

Well that's one way of comparing these two drafts, but I'm not too keen on this workflow. I have no further use for this temporary file, so I'll have to clean up afterwards by removing it.

    rm 45-shownotes.md 

Also, I usually have an instance of Vim open already, and I'd prefer a workflow that didn't require me to open a fresh instance of Vim.

Let's see if we can come up with a better workflow. I'll launch Vim as usual, and set up a couple of split windows. Suppose that I'm working on this local copy, and I decide that I want to compare it with the latest revision. I want to keep this workspace as it is, so I'll open a new tabpage with the current buffer:

    :tabedit %

Next, I'll open a new empty buffer in a vertical split:

    :vnew

I'd like to keep my draft on the left, so I'll swap the position of these two split windows.

Then I'll copy the text from the textarea on the webpage, and paste the clipboard contents into my empty buffer:

    :0put+

Vim lets us start diff mode with the contents of our existing windows, by running the command:

    :windo diffthis

Boom! We can see the changes between these two versions.

The nice thing about this technique is that we can use an unnamed buffer - there's no need to write the text to a temporary file. In this case, the buffer on the left corresponds to a file on my local filesystem, while the buffer on the right has no associated file. This technique would work just as well if neither buffer had been saved to disk, which makes it pretty flexible.

We can turn diffmode off again just as easily, by running:

    :windo diffoff

Because we set up a fresh tabpage for these two windows, we can easily switch back to the other tabpage containing our previous workspace, which is just as we left it.
