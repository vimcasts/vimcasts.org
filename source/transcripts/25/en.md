Starting with a blank slate
===========================

Colorschemes are kept in a directory called `colors` inside your `$VIMRUNTIME` directory. I'm going to start with a blank slate, and create a new file called `demo_light.vim`.

There's a little bit of boilerplate code that should be included at the top of every colorscheme, so I'll begin by pasting that in:

    set background=light
    highlight clear
    if exists("syntax_on")
      syntax reset
    endif
    let g:colors_name = "Demo light"

I've named the colorscheme file demo-underscore-light, so I'll set the `colors_name` variable to the human friendly form "Demo light".

The background should be set to either `light` or `dark`. If I apply this colorscheme now:

    :colorscheme demo_light

You'll see that the default colors can be easily read on a light background. If I set background to `dark`, then reapply the colorscheme, Vim applies default colors which would look suitable on a dark background. The `background` setting does not actually set the background color. Instead, it chooses an appropriate set of default colors which will be readable on either a light or a dark background.

You can specify any background color you like by hooking in to the 'Normal' group with the `highlight` command. 

The `highlight` command takes a group name as the first argument, followed a series of key/value pairs. The group name represents the element that you want to style. The keys can be any of these:

* term
* ctermbg
* ctermfg
* cterm
* guibg
* guifg
* gui

The `term` key applies to non-color terminals. The keys beginning with `cterm` apply to color terminals, and those beginning with `gui` apply to Grapical Vim. To begin with, I'm going to focus on the GUI keys, but I'll return to the terminal options later.

`bg` stands for background, so the `guibg` key lets you assign a background color for the specified group. `fg` stands for 'foreground', so the `guifg` key allows you to assign a color for the actual text of the specified group. Both `guifg` and `guibg` keys accept a hex color code. Finally, the `gui` key can accept values such as: bold, italic and underline.

Styling syntax elements
=======================

Revealing syntax groups
-----------------------

If you want to change the color of an element, the first thing you need to know is to which syntax highlighting group it belongs. 

In TextMate, you can reveal the *scope* of any element by pressing the `ctrl-shift-p` keys. This brings up a tooltip showing information about which *scopes* the current word belongs to. You can then tweak the style of the selected element in the "Themes" panel of TextMate's preferences.

Vim doesn't have a syntax inspector built in, but it can be added with a small amount of Vimscript. I keep this in my `.vimrc` file:

    " Show highlighting groups for current word
    nmap <C-S-P> :call <SID>SynStack()<CR>
    function! <SID>SynStack()
      if !exists("*synstack")
        return
      endif
      echo map(synstack(line('.'), col('.')), 
      \       'synIDattr(v:val, "name")')
    endfunc

I've set this up to use the same `ctrl-shift-p` shortcut as TextMate. Now, I can position my cursor on any word, and pressing `ctrl-shift-p` will reveal the syntax groups to which the element belongs. With that information, it's straightforward to open up a colorscheme file and edit or create a style for the word in question.

Defaults must be overridden
---------------------------

When you start creating a new colorscheme from scratch, you do not begin with an empty color palette. Instead, Vim provides default colors to go with your light or dark background. The default colors will endure until you explicitly override them. This can lead to some surprising color clashes. 

    " TODO: Override default 'TODO' colors

For example, here I have a comment which starts with the word 'TODO' in all-caps. The default colors for a light theme make this show up in blue on a yellow background. Suppose I just want `TODO` to appear as red text, I could create a style specifying the text color as red:

    highlight Todo guifg=#cc0000

I'll save the file, and reapply this style, and as you can see, it has overridden the color of the text, but the yellow background remains. To get rid of the default styling, I have to override the background. The keyword 'NONE' achieves this.

    highlight Todo guifg=#cc0000 guibg=NONE

If you want to be sure that your colorscheme is not contaminated with default colors, I would recommend using the keyword 'NONE' everywhere, to override all keys that you are not explicitly setting. This makes the colorscheme source code somewhat harder to read, but it's more important that the colorscheme itself actually looks the way you expect it to.

Linking to existing groups
--------------------------

When styling a syntax group with the highlight command, things can start to look very verbose. If you have two groups to which you want to apply the same styles, you needn't repeat the entire style. Instead, you can use the `highlight link` command. For example:

    highlight htmlH1 gui=bold guifg=NONE guibg=NONE
    highlight link htmlH2 htmlH1
    highlight link htmlH3 htmlH1
    highlight link htmlH4 htmlH1

if I create a style to make html level 1 headings bold, I can quickly apply the same style to level 2, 3 and 4 headings just by linking those highlighting groups.

A note on fonts
---------------

Since the beginning of time, Monaco has been the default monospaced typeface on Macintosh computers. Personally, I like the look of it, but it does have one limitation: there are no bold or italic fonts for Monaco. TextMate is capable of creating faux-italics from the regular font, but MacVim doesn't do this. So if you want to be able to use italics and bold in your colorscheme, you probably want to choose a typeface that includes these fonts. With Snow Leopard, Apple has switched the default monospaced typeface to Menlo, which does include bold and italic fonts.

Styling Vim's interface
=======================

Besides styling syntax, you can also tweak the appearance of Vim's interface to match your colorscheme. You can get a list of the default highlighting groups by looking up `:help highlight-groups`. 

It's easy to overlook some elements of Vim's interface, because they may not be continuously visible. For example, line numbers can be switched on or off; the status line may only be visible when windows are split; and visual selections are highlighted only when visual mode is enabled. So be sure to test the appearance of these elements. I've provided a checklist in the shownotes.

Helpful tools
=============

Colorize hex codes
------------------

When working with hex values, it's really helpful if you can see the color that the code represents. Yuri Feldman has created a lightweight hexHighlight script that allows you to toggle hex color syntax highlighting. I find this very helpful when working on colorschemes.

Export TextMate themes to Vim
-----------------------------

Coloration is a tool created by Marchin Kulik, which makes it really easy to convert TextMate themes into Vim colorschemes. You can download the rubygem to use it at the command line, or you can just upload the file for a TextMate theme to the webpage.

Note that coloration expects TextMate themes in XML format, whereas TextMate itself tends to save themes in a binary `.tmTheme` format. You can use the `plutil` tool to convert plist files from binary to XML format:

    plutil -convert xml1 Amy.tmTheme

This will overwrite the file `Amy.tmTheme` with an XML representation of the same data, creating a file that Coloration can handle.


Make GUI themes work on color terminals
---------------------------------------

When defining colorschemes for the GUI, you can specify precice colors using RGB values. But when Vim runs in the terminal, you can't specify colors in this way. Instead, you have to use an indexed color palette, which could include 8, 16, 88 or 256 colors, depending on the terminal in use.

Shawn Biddle has created a script that updates GVim colorschemes to work in color terminals. Once installed, you simply open in Vim the colorscheme that you want to change, then source the the "to-cterm dot vim" script. For each GUI style, this script will translate the hex value into the corresponding index for a 256 color terminal.

If you work on a mac, note that the Terminal application only supports 16 colors. If you want to test your colorscheme in a 256 color terminal, you could try using iTerm instead.

I recently ported the "Mac Classic" theme from TextMate to Vim. Here you can see it side by side in the GUI and in a 256 color terminal. I used Shawn's Vim-toCterm script to create the color terminal version, and I think it's a pretty good match.

