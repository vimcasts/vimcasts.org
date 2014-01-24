If you want to work with multiple files in Vim, the most basic command that you must learn is `:edit`. 

Depending on what arguments you supply, the `:edit` command may do one of 3 things:

* pass it the name of a file, and it will open that file in the current window
* pass it the name of a directory, and it will open a file explorer for that directory
* when called with no arguments, the `:edit` command will revert to the latest saved version of the current file. To discard unwanted changes, you will have to force this command with a trailing '!' bang.

When you launch Vim from the terminal, it automatically sets Vim's working directory to match the current directory on the command line. When opening a file with the `:edit` command, you can specify the path relative to this working directory. 

So if I launch Vim from the root of a project, then I can easily find my way to whichever file I need. After typing a few characters I can hit the tab key and, if a match is found, it will autocomplete it for me. So I can quickly drill down through the directories to find a file. 

But if I want to open several files in the same directory, this can start to feel like a lot of extra work. Maybe it would save time if I could change the working directory to the one containing the files that I want to work on.

Change directory to match current file
--------------------------------------

In Vim's command mode, the '%' sign is a shorthand for the current file. So as a first guess, I might attempt something like this:

    :cd %

This raises an error. If I expand the '%' sign, I get the path to the current file. So I just told Vim to change directory, but gave it the path to a file rather than a directory. 

The way that Vim expands the '%' sign can be customised with a few modifiers. I'm going to use the `:echo` command here to demonstrate. 

    :echo expand('%')

The percent sign gives the path to the current file relative to the current working directory.

    :echo expand('%:p')

The `:p` 'colon-p' modifier expands this into an absolute path.

    :echo expand('%:p:h')

The `:h` 'colon-h' modifier returns the 'head' of the path. Or in other words, it removes the last component, which in this case is the filename.

So now lets try changing to the directory of the current file by applying these modifiers:

    :cd %:p:h

Now if I print the working directory, you can see that it has changed. 

This makes it much easier for me to open files that are in the same directory as the file that I am currently working on. But what if I want to work on a file that is not in this directory? Now I have to climb back up the directory tree, before drilling down again to the level of the file that I want to open. I find this dissorienting. I've created a bigger problem than the one I was trying to solve.

By keeping the current working directory at the root of the project, I can always find my way to a file. I prefer to create a dedicated shortcut for opening files from the same directory as the currently active file. I have the following in my .vimrc

    map <leader>ew :e <C-R>=expand("%:p:h") . "/" <CR>

I've set my leader key to comma, but the default in Vim is backslash. If I press 'comma-e-w', it's as though I have issued the ':edit' command then drilled down to the directory of the current file. I can hit 'tab' to autocomplete, and again to scroll through the available files.

'ew' stands for 'edit in window'. I have also created shortcuts to edit in split, or vertical split, or in a new tab.

    map <leader>es :sp <C-R>=expand("%:p:h") . "/" <CR>
    map <leader>ev :vsp <C-R>=expand("%:p:h") . "/" <CR>
    map <leader>et :tabe <C-R>=expand("%:p:h") . "/" <CR>

If you like, you can copy these mappings from the shownotes into your own .vimrc.
