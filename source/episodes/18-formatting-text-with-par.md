--- 
:title: Formatting text with par
:date: 2010/05/03
:poster: /images/posters/formatting_text_with_par.png
:flattr_id: "31943"
:duration: 312
:number: 18
:ogg: 
  :url: http://media.vimcasts.org/videos/18/formatting_with_par.ogv
  :size: 7937415
:quicktime: 
  :url: http://media.vimcasts.org/videos/18/formatting_with_par.m4v
  :size: 17975374
:tags: plaintext, wrapping, external-filters
:layout: episode
---

'Do one thing and do it well' is the principle of the Unix toolkit. Editing text is a broad domain, and there are many related tasks with which it overlaps. Vim acknowledges this by enabling certain tasks to be outsourced to external programs which do that one thing, and do it well. This episode will demonstrate how the *par* program can be used for formatting text.


READMORE


[Par][par] was written by Adam Costello in 1993, aiming to do one narrow task: reformat a single paragraph that might have a border on either side. The [documentation][par_doc] is terse, and the author apologises for the implementation being unclean. Nevertheless, the program is stable, portable, and most important of all, extremely useful.

The `formatprg` option allows you to specify an external program that will be called when you run the `gq` command. The simplest possible configuration would be:

    :set formatprg=par

By default, par sets line width at 72 columns. You can alter this by passing the `-w` flag with a number, for example:

    :set formatprg=par\ -w50

This sets the line width to 50 columns. The backslash is necessary to escape the space at the command line. There are many different flags that can be passed to the par program in this fashion. You can view a summary of these by running `par help` at the command line. 

In the video, I give a quick overview of the following options:

* w - specify line length
* r - repeat characters in bodiless lines
* j - justifies text
* e - remove 'superflous' lines
* q - handle nested quotations in plaintext email

## Installing par

Before you can call par from Vim, you will have to make sure that it is installed on your system. 

###Installing Par on OS X with macports

If you have macports installed, you can [install par on OS X][par_osx] by running:

    sudo port install par

You will be prompted for your password.

###Installing par on other platforms

I haven't had time to try this out on either Linux or Windows. Please leave a comment if you find an article on the web with good instructions on how to install par, or build it from source.

### Further reading

* [`:help formatprg`][formatprg]
* [Par homepage][par]
* [Par documentation][par_doc]
* [Installing par on OS X][par_osx]

[formatprg]: http://vimdoc.sourceforge.net/htmldoc/options.html#'formatprg'
[par]: http://www.nicemice.net/par/
[par_doc]: http://www.nicemice.net/par/par-doc.var
[par_osx]: http://par.darwinports.com/
