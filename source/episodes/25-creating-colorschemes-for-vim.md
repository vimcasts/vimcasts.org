--- 
:title: Creating colorschemes for Vim
:date: 2010/09/28
:poster: /images/posters/colorschemes.png
:flattr_id: "67028"
:duration: 584
:number: 25
:ogg: 
  :url: http://media.vimcasts.org/videos/25/colorschemes.ogv
  :size: 18548209
:quicktime: 
  :url: http://media.vimcasts.org/videos/25/colorschemes.m4v
  :size: 25039525

---

Choosing a colorscheme that you find pleasing to look at is essential if you want to be comfortable working with Vim. There are hundreds of colorschemes available, but what if you can't find one that you like? In this episode, I'll share a few tips that make it easy to create colorschemes for Vim.


READMORE


### Revealing syntax groups

If you want to change the color of an element, the first thing you need to know is to which syntax highlighting group it belongs. 

In TextMate, you can reveal the *scope* of any element by pressing the `ctrl-shift-p` keys. This brings up a tooltip showing information about which *scopes* the current word belongs to. You can then tweak the style of the selected element in the "Themes" panel of TextMate's preferences.

Vim doesn't have a syntax inspector built in, but it can be added with a small amount of Vimscript. I keep this in my `.vimrc` file:

<pre class="brush: vimscript">
&quot; Show syntax highlighting groups for word under cursor
nmap &lt;C-S-P&gt; :call &lt;SID&gt;SynStack()&lt;CR&gt;
function! &lt;SID&gt;SynStack()
  if !exists(&quot;*synstack&quot;)
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, &quot;name&quot;)')
endfunc
</pre>

I've set this up to use the same `ctrl-shift-p` shortcut as TextMate. Now, I can position my cursor on any word, and pressing `ctrl-shift-p` will reveal the syntax groups to which the element belongs. With that information, it's straightforward to open up a colorscheme file and edit or create a style for the word in question.

**UPDATE**: thanks to Gerardo Galindez for bringing [HiLinkTrace][] to my attention. This script can reveal a list of *all* of the matching syntax groups. It's much more powerful than the little snippet of Vimscript above.

### Default colors

When you reset the syntax highlighting, it doesn't just set everything to black and white. Instead, it uses the default colors defined in the file `$VIMRUNTIME/syntax/syncolor.vim`. If you're curious, you can open this file in Vim by running `:edit $VIMRUNTIM/syntax/syncolor.vim`. 

### Styling Vim's interface

You can get a list of the default highlighting groups by looking up [`:help highlight-groups`][hi-groups]. 

It's easy to overlook some elements of Vim's interface, because they may not be continuously visible. Here is a checklist of things that you should consider:

* can you see the cursor?
* enable line & columns highlighting (`:set cul cuc`). Can you see a crosshair for the cursor position?
* enable line numbering (`:set number`). Can you see the line numbers?
* split a window with `:split` and `:vsplit`. Are the status lines and vertical separators clearly visible? Can you tell which is the current window?
* enable hlsearch (`:set hls`) and search for a pattern. Can you see the matches?
* go into visual mode (shift-V). Can you easily see which line is selected? Can you differentiate between visual mode and highlighted search matches?
* fold some text (`:set foldmethod=manual` then make a visual selection and press `zf`). Can you identify the folded text? 
* bring up the autocomplete popup menu (type the first few characters of a word, then press `ctrl-n`). Is it clear which item in the list is selected?
* position your cursor on some brackets. Does the matching bracket stand out in a way that is identifiable? Could the matching bracket be confused with the cursor?

For each of the above questions, you should not just be asking "can I see X", but also "does X look good with the existing colors?". When devising a palette for a colorscheme, you may want to choose a handful of colors that you want to use for syntax coloring, then choose a complimentary set of colors to use for styling Vim's interface.

### Syntax highlighting hex values

When working with hex values, it's really helpful if you can see the color that the code represents. Yuri Feldman has created a lightweight [hexHighlight][hex] script that allows you to toggle hex color syntax highlighting. If you install the plugin, it maps the toggle function to `<leader><F2>`. I prefer to use `,h` so I keep the following in my .gvimrc:

<pre class="brush: vimscript">
if exists('*HexHighlight()')
  nmap &lt;leader&gt;h :call HexHighlight()&lt;Return&gt;
endif
</pre>

Note that this plugin requires GVim. If you call the `HexHightlight()` function while running Vim in a terminal, it will notify you: *"hexHighlight only works with a graphical version of Vim"*.
 
### Coloration

[Coloration][github] is a tool created by Marcin Kulik, which makes it really easy to convert TextMate themes into Vim colorschemes. You can download the rubygem to use it at the command line, or you can just [upload the file for a TextMate theme to the webpage][coloration].

Note that coloration expects TextMate themes in XML format, whereas TextMate itself tends to save themes in a binary `.tmTheme` format. The `.tmTheme` extension is just a nicety - under the hood it's really a property list (plist) file. You can use the `plutil` tool to convert plist files from binary to XML format as follows:

    plutil -convert xml1 Amy.tmTheme

This will overwrite the file `Amy.tmTheme` with an XML representation of the same data, creating a file that Coloration can handle.

### Making your colorscheme work on color terminals

Shawn Biddle has created a [script that updates GVim colorschemes to work in color terminals][cterm]. Follow the installation instructions on [the project page][cterm]. Once installed, you simply open the colorscheme that you want to change in Vim, then source the the `tocterm.vim` script. For each GUI style (such as `guifg=#d7005f`), this script will translate the hex value into the corresponding index for a 256 color terminal (e.g. `ctermfg=161`).

Note that the Vim-toCterm script assumes that the terminal has 256 colors. If you are running Vim inside a terminal with fewer colors (such as OS X Terminal, which has only 16!), then the colorscheme generated by the script will be of no use to you. Mac users can test their colorschemes in [iTerm][iterm], which does support 256 colors.

### Further reading

* [HiLinkTrace][] - a plugin for revealing all syntax groups
* [StackOverflow: revealing syntax groups][so]
* [Coloration][coloration] - a tool for converting TextMate themes to Vim colorschemes
* [Converting plist files from binary to XML format][plutil]
* [HexHighlighter][hex] - a plugin to toggle hex colors
* [coloresque][] - another plugin to visualize colors (including hsl and named colors)
* [Vim-toCterm][cterm] - a script that updates GUI colorschemes to work in color terminals
* [palette][pal] - an easier way to write Vim color schemes (rubygem)

[HiLinkTrace]: https://github.com/gerw/vim-HiLinkTrace
[coloration]: http://coloration.sickill.net/
[github]: http://github.com/sickill/coloration
[plutil]: http://hints.macworld.com/article.php?story=20050430105126392
[so]: http://stackoverflow.com/questions/1467438/find-out-to-which-highlight-group-a-particular-keyword-symbol-belongs-in-vim
[cterm]: http://shawncplus.github.com/Vim-toCterm/
[hex]: http://www.vim.org/scripts/script.php?script_id=2937
[hi-groups]: http://vimdoc.sourceforge.net/htmldoc/syntax.html#highlight-groups
[iterm]: http://iterm.sourceforge.net/
[pal]: http://github.com/joshuaclayton/palette
[coloresque]: https://github.com/gorodinskiy/vim-coloresque
