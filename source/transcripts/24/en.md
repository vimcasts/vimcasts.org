When you launch vim, it will automatically load and execute your vimrc file. If you modify the vimrc file whilst Vim is running you can apply those changes by running the command:

    :source $MYVIMRC
    "colon source - dollar my vim-R-C in all caps"

"dollar my vim-R-C" is a constant which should work whether you are running Vim on a unix system or on Windows.

Of course, you have to save the changes to your vimrc file before sourcing it. Now, I can't see myself wanting to save my `vimrc` file and *not* apply any changes. So I have added an autocommand to my vimrc file:

    " Source the vimrc file after saving it
    if has("autocmd")
      autocmd bufwritepost .vimrc source $MYVIMRC
    endif

This breaks down as follows:

    .vimrc

If the current file is called "dot-vimrc", 

    autocmd bufwritepost

fire this autocommand after writing the buffer to disc.

    source $MYVIMRC

When this event is triggered, Vim will automatically source your vimrc, applying any changes which you just saved.

To demonstrate this, I'm going to apply a different colorscheme. You should be able to see that the new colorscheme is applied as soon as I write my vimrc file.

Quickly open the vimrc file
===========================

I also like to make it as easy as possible to open my vimrc file.

    let mapleader = ","
    nmap <leader>v :tabedit $MYVIMRC<CR>

This mapping opens the vimrc file in a new tab when I hit "comma-v" in normal mode. "V" is my mnemonic for vimrc. Feel free to modify the mappings, and the functionality to suit your preferences.