# WHITESPACE PREFERENCES PER FILETYPE

Setting tab/space preferences per filetype
------------------------------------------

It is sometimes necessary to use different indentation settings for particular types of file.

It might be that the filetype itself is fussy about tabs versus spaces. For example, makefiles should be indented with tab characters, whereas YAML files must be indented with spaces. 

Or perhaps you have to follow a 'house-style' which specifies that, say, html and css files be indented with 2 spaces, while javascript is indented with tab characters of width 4.

You can set these preferences in your `.vimrc` file, by hooking into the `FileType` event with an autocommand:

    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    autocmd FileType html setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=2 sts=2 sw=2 expandtab
    autocmd FileType javascript setlocal ts=4 sts=4 sw=4 noexpandtab

This command consists of two parts:

    autocmd FileType javascript

The first half indicates that when the filetype is set to javascript, the second half of the command will be executed. The second half

    setlocal ts=4 sts=4 sw=4 noexpandtab

calls `setlocal`, applying the following settings to the current buffer, which in this case contains javascript. Using setlocal ensures that these settings are not altered for any other buffers that happen to be open at the time, and may contain something other than javascript.



This functionality is only available when Vim is compiled with the `autocmd` flag enabled. You can check if your version of Vim has this capability by running the command:

    :version

If you see a minus sign in front of `autocmd`, then this functionality is not available in your copy of Vim. A plus sign means it is available. You also need to enable filetype detection, by including the following line in your `.vimrc`:

    filetype on

You can test if your version of Vim has been compiled with support for autocommands using a conditional statement:

    if has("audocmd")
      ...
    endif

By placing all of your autocommands inside this block, you can keep your `.vimrc` file portable. This means you can load the same `.vimrc` in a minimal Vim, compiled without the autocmd feature, and it shouldn't raise any errors.


###More on filetypes

There will be times when you are editing a file, and Vim is unable to guess the filetype. You can find out what the current filetype is, by running:

    :set filetype?

or the shorthand:
  
    :set ft?

I would like Vim to treat this RSS file as XML. I can tell it to do so by running:

    :set filetype=xml
    "set filetype EQUALS xml"

or the dedicated command:

    :setfiletype xml
    "one word: setfiletype SPACE xml"

You should be able to see the difference, as the syntax highlighting kicks into action.

### Match extensions to filetypes

To tell Vim to always treat files with the `rss` extension as XML, I can put the following in my `.vimrc` file:

    autocmd BufNewFile,BufRead *.rss setfiletype xml

The first half

    autocmd BufNewFile,BufRead *.rss

indicates that when a new or existing file with the `rss` extension is opened, the second half of the command will be executed.

    setfiletype xml

the second half sets the filetype to xml. 

It is possible to specify multiple patterns to be matched when opening a file. Just separate them with a comma. So the autocommand could be tweaked so that it also match atom files. 

    autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml

Please note that when I opened the example RSS file in Vim, it automatically set the filetype to XML, even before I added this autocommand to my `vimrc` file. The example given here is purely for illustrative purposes. 
