--- 
:title: How to fold
:date: 2012/11/19
:poster: /images/posters/how_to_fold.png
:flattr_id: "1003463"
:duration: 529
:number: 37
:ogg: 
  :url: http://media.vimcasts.org/videos/37/how-to-fold.ogv
  :size: 17856957
:quicktime: 
  :url: http://media.vimcasts.org/videos/37/how-to-fold.m4v
  :size: 27341198

---

Vim's folding feature enables us to expand and collapse regions of a document. Not only does this allow us to organize our workspace, it also makes it easy to navigate around the document, and to rearrange entire sections as though they were single lines.


READMORE

<r:snippet name="announcement"/>

## Methods of folding

Vim has several different methods for folding a document. You can read more about them by looking up [`:help fold-methods`][fdm]. I don't want to go into much detail about these different methods, except to say that I've found using a [custom expression][fold-expr] to be the most useful method by far.

For the purposes of the demonstration in this video, I used a markdown file, with the [`markdown-folding`][plugin] providing the fold expression. [Episode 38][next] will look at how the markdown folding expression is implemented, here we focus on *how to use* folding.

## Essential folding commands

Top of any Vim folding cheat sheet should be the `zi` command, which turns the folding functionality on and off. Here are the folding commands which I use most frequently:

<table>
    <tr>
        <th>command</th>
        <th>effect</th>
    </tr>
    <tr>
        <td><code>zi</code></td>
        <td>switch folding on or off</td>
    </tr>
    <tr>
        <td><code>za</code></td>
        <td>toggle current fold open/closed</td>
    </tr>
    <tr>
        <td><code>zc</code></td>
        <td>close current fold</td>
    </tr>
    <tr>
        <td><code>zR</code></td>
        <td>open all folds</td>
    </tr>
    <tr>
        <td><code>zM</code></td>
        <td>close all folds</td>
    </tr>
    <tr>
        <td><code>zv</code></td>
        <td>expand folds to reveal cursor</td>
    </tr>
</table>

I recommend learning these commands first. The `za` command is so useful that you may want to consider mapping it to a single keystroke. Steve Losh suggests using this mapping:

    nnoremap <Space> za

While `za` is great for opening folds, the `zc` command is often more suitable when you want to close a fold. If the current fold is already closed, then `zc` will close the parent fold.

## Navigating the unfolded document

Even when the document is fully unfolded, the fact that Vim knows where the folds start and finish gives us an additional method for moving around.

<table>
    <tr>
        <th>command</th>
        <th>effect</th>
    </tr>
    <tr>
        <td><code>zj</code></td>
        <td>move down to top of next fold</td>
    </tr>
    <tr>
        <td><code>zk</code></td>
        <td>move up to bottom of previous fold</td>
    </tr>
</table>

The custom fold expression adds a whole new layer of semantics, which allows us to rapidly navigate the sections of the document.

## More folding commands

Here are some more folding commands:

<table>
    <tr>
        <th>command</th>
        <th>effect</th>
    </tr>
    <tr>
        <td><code>zo</code></td>
        <td>open current fold</td>
    </tr>
    <tr>
        <td><code>zO</code></td>
        <td>recursively open current fold</td>
    </tr>
    <tr>
        <td><code>zc</code></td>
        <td>close current fold</td>
    </tr>
    <tr>
        <td><code>zC</code></td>
        <td>recursively close current fold</td>
    </tr>
    <tr>
        <td><code>za</code></td>
        <td>toggle current fold</td>
    </tr>
    <tr>
        <td><code>zA</code></td>
        <td>recursively open/close current fold</td>
    </tr>
    <tr>
        <td><code>zm</code></td>
        <td>reduce `foldlevel` by one</td>
    </tr>
    <tr>
        <td><code>zM</code></td>
        <td>close all folds</td>
    </tr>
    <tr>
        <td><code>zr</code></td>
        <td>increase `foldlevel` by one</td>
    </tr>
    <tr>
        <td><code>zR</code></td>
        <td>open all folds</td>
    </tr>
</table>

## Chaining folding commands

Vim's folding commands operate at a low level. Sometimes, we have to chain a couple of these low level commands together to produce the desired result. For example, pressing `zMzv` has the effect of closing all open folds *apart from the one that the cursor is on* (see the video for a demonstration).

## Further reading

* [`:help fold-commands`][fold-commands]
* [`:help fold-methods`][fdm]
* [`:help fold-expr`][fold-expr]
* [markdown-folding plugin][plugin]
* [Steve Losh's fold mappings][sjl]

[sjl]: https://github.com/sjl/dotfiles/blob/eea18b00b8c74943f5094fddf91d3c2a7e0a7242/vim/vimrc#L534
[gist]: https://gist.github.com/1038710
[fdm]: http://vimdoc.sourceforge.net/htmldoc/fold.html#fold-methods
[fold-expr]: http://vimdoc.sourceforge.net/htmldoc/fold.html#fold-expr
[fold-commands]: http://vimdoc.sourceforge.net/htmldoc/fold.html#fold-commands
[next]: /e/38
[plugin]: http://github.com/nelstrom/vim-markdown-folding
[q]: http://stackoverflow.com/questions/3828606/vim-markdown-folding
[48]: http://learnvimscriptthehardway.stevelosh.com/chapters/48.html
[49]: http://learnvimscriptthehardway.stevelosh.com/chapters/49.html