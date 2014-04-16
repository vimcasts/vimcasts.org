--- 
:title: Mac Classic - a light colorscheme
:date: 2010/09/28
:tags: colorschemes
---

I could never find a light colorscheme for Vim that I enjoyed using, so I finally took the time to port the "Mac Classic" theme from TextMate. The [source code is on gitub][github], so feel free to fork it.

[github]: http://github.com/nelstrom/vim-mac-classic-theme

READMORE

<a href="http://github.com/nelstrom/vim-mac-classic-theme">
  <img src="http://vimcasts.org/images/blog/mac_classic.png" style="margin:1em 0;" title="Screenshot of Mac Classic theme, with Inconsolata typeface"/>
</a>

While making this colorscheme, I learned of a few useful tools. To get started, I used Marcin Kulik's [Coloration][col] tool, to convert the TextMate theme into a Vim colorscheme. The result looked pretty good for syntax elements, but the colors for Vim's interface needed some heavy tweaking.

I discovered Yuri Feldman's [hexHighlight.vim script][hex], which detects hex codes, and highlights them with the color that they represent.

To begin with, I just created the "Mac Classic" theme to work in GVim, but [people started asking if I was planning on making it work in color terminals][256Q]. That was when I recalled that Shawn Biddle had created [a script for converting GUI colorschemes to work in color terminals][cterm]. I ran the "Mac Classic" theme through Shawn's script, and was pleased with the results.

My latest screencast on [creating colorschemes for Vim](/e/25) goes into more detail on how I used each of these tools.

[col]: http://coloration.ku1ik.com/
[hex]: http://www.vim.org/scripts/script.php?script_id=2937
[cterm]: http://shawncplus.github.com/Vim-toCterm/
[256Q]: http://twitter.com/claytron/status/25113763230
