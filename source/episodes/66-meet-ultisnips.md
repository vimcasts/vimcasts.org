---
:title: Meet UltiSnips
:date: 2014/05/21
:poster: /images/posters/meet-ultisnips.png
:duration: 343
:number: 66
:tags: Insert mode, plugins
---

Snippets allow you to quickly insert predefined chunks of text into your document. The feature as I know it was first introduced in TextMate, but it has since been emulated by many other editors. For Vim users who want this functionality, the UltiSnips plugin is a great choice. Let's start by looking at the basics.

READMORE

You can find [UltiSnips on github][UltiSnips]. The README file contains installation instructions.

### Basic features

This screencast demonstrates the basic features of UltiSnips: tabstops, placeholders, mirroring, and shell interpolation.

A tabstop is a location that we can jump to when the snippet is activated (`:h UltiSnips-tabstops`). UltiSnips lets us define tabstops sequentially using `$1`, `$2`, `$3`, and so on. The `$0` tabstop is special: it defines the final position of the cursor, regardless of how many tabstops you specify.

We can use placeholders to provide default text for a tabstop. For example, to make tabstop one default to "Insert a title", we would change `$1` to:

    ${1:Insert a title}

If we wanted to generate a placeholder text dynamically, we could use shell interpolation (`:h UltiSnips-shellcode`). This snippet would use today's date as a placeholder for tabstop two:

    ${2:`date +%Y-%m-%d`}

If we want to insert the same text in two different locations, we can use mirroring (`:h UltiSnips-mirrors`). In this snippet, the second instance of the `$1` tabstop will mirror the contents of the first tabstop:

    snippet fmatter
    ---
    title: ${1:Meet UltiSnips}
    date: ${2:`date +%Y-%m-%d`}
    tags: $3
    ---
    # $1
    $0
    endsnippet

That gives us the title twice: once in the yaml frontmatter, then again as a header at the top of the markdown document.

### UltiSnips triggers

By default, UltiSnips provides the following mappings:

<table>
   <tr>
       <th>command</th>
       <th>action</th>
   </tr>
   <tr>
       <td><code>&lt;tab&gt;</code></td>
       <td>expand trigger</td>
   </tr>
   <tr>
       <td><code>&lt;C-j&gt;</code></td>
       <td>advance to next tabstop</td>
   </tr>
   <tr>
       <td><code>&lt;C-k&gt;</code></td>
       <td>reverse to previous tabstop</td>
   </tr>
</table>

In TextMate, you can jump forward and back between tabstops by pressing tab or shift-tab (hence the name *tabstop*!). You can make UltiSnips behave the same way by putting these lines in your .vimrc file:

```viml
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
```

Look up `:help UltiSnips-triggers` for more details.

### UltiSnips can replace SnipMate

[SnipMate][snipmate] is another popular snippet plugin for Vim, which supports all of the features demonstrated in this screencast. SnipMate is implemented in pure Vimscript, making it more widely available than UltiSnips, which requires `+python` support. However, UltiSnips provides some powerful features which are not (currently) supported by SnipMate. We'll cover some of these features in another episode.

SnipMate and UltiSnips both define their snippets using slightly different formats, but UltiSnips will happily parse both formats. If the snippet file is called `snippets/filetype.snippets` then UltiSnips expects SnipMate style definitions, but if the file is called `UltiSnips/filetype.snippets` then UltiSnips will use its native format. (You can't mix up SnipMate and UltiSnips formats within the same file.) If you want to switch from SnipMate to UltiSnips, you can keep on using all of the snippets that you defined for use with SnipMate. UltiSnips is a drop-in replacement for SnipMate.

### Snippets library

Honza Pokorny maintains the [vim-snippets][snippets] repository, which contains a library of snippets for many common languages. Installing this plugin will give you access to hundreds of snippets. Personally, I prefer to treat that repository as a reference. I cherry-pick the snippets that look useful to me, and add them to my personal snippet library.

### Further reading

* `:h UltiSnips-adding-snippets`
* `:h UltiSnips-tabstops`
* `:h UltiSnips-mirrors`
* `:h UltiSnips-shellcode`
* `:h UltiSnips-triggers`
* [`:h Select-mode`][select]
* [UltiSnips][]
* [SnipMate][]
* [vim-snippets][snippets]

[UltiSnips]: https://github.com/SirVer/ultisnips
[snippets]: https://github.com/honza/vim-snippets
[SnipMate]: https://github.com/garbas/vim-snipmate
[select]: http://vimdoc.sourceforge.net/htmldoc/visual.html#Select-mode
