--- 
:title: Spell checking
:date: 2010/05/10
:poster: /images/posters/spell_checking.png
:flattr_id: "31944"
:duration: 342
:number: 19
:ogg: 
  :url: http://media.vimcasts.org/videos/19/spell_checking.ogv
  :size: 7475923
:quicktime: 
  :url: http://media.vimcasts.org/videos/19/spell_checking.m4v
  :size: 16539933
:tags: plaintext, wrapping
:layout: episode
---

Using a spell checker is a good habit to get into.  In this episode, I demonstrate how to use Vim's built in spell checking feature.


READMORE


Spell checking is enabled by running `:set spell`. I like to be able to quickly toggle spell checking on and off, so I keep the following in my .vimrc:

<pre class="brush: vimscript">
&quot; Toggle spell checking on and off with `,s`
let mapleader = &quot;,&quot;
nmap &lt;silent&gt; &lt;leader&gt;s :set spell!&lt;CR&gt;

&quot; Set region to British English
set spelllang=en_gb
</pre>

The default `spelllang` is `en`, which includes all regions of English. In the example above, I run `set spelllang=en_gb`, which sets the region to British English. The available regions for the English language are:

* `en` - all regions
* `en_au` - Australia
* `en_ca` - Canada
* `en_gb` - Great Britain
* `en_nz` - New Zealand
* `en_us` - USA

When the region is set to British English, American spellings (e.g. 'color') are highlighted as regional variations, rather than being marked as misspellings.

The value of `spelllang` can be set locally to each buffer. This means it is possible to have several documents open at once, and for each to have their own spelling dictionary. If you would prefer to set the spelllang to the same value for all documents, you can run one of the following:

    :windo set spelllang=en_us
    :bufdo set spelllang=en_us

The first of these will set the spelling dictionary for all windows in the current tabpage. The second one will apply the spelling dictionary to all open buffers.

###Usage

You can advance through the highlighted spelling errors with the `]s` command, or you can move through them backwards with the `[s` command. 

When the cursor is on a misspelled word, you can bring up a list of suggested corrections with the command `z=`. The prompt at the bottom of the screen advises you to enter the number of the word you want to use in place of the misspelled word, then hit enter. This takes you back to your document, with the correction applied.

If you prepend the `z=` command with a count, it will take that word from the list of suggested corrections without even showing you the list. So if you are confident that the first suggestion is the one you want, you could instead run `1z=`.

###Adding and removing words to spellfile

By default, Vim will load a spellfile from the location:

    ~/.vim/spell/LL.EEE.add

Where `LL` is the language and `EEE` is the encoding of the file in the active window. For example, if you are editing a file whose encoding is UTF-8, with `spelllang` set to `en_us` then Vim will look for a spell file at `~/.vim/spell/en.utf-8.add`
 
If you don't want to correct a word, you can add it to the `spellfile` with the `zg` command. You can also remove a word from the spelling dictionary with the `zw` command. If you change your mind, each of these commands can be reverted with the undo commands `zug` and `zuw`, respectively.

### Spelling dictionaries for other languages

Out of the box, Vim comes with a spelling dictionary for the English language. If you want to spell check another language, you have to first install the spell file for it. Here is a good article on [creating a spell file for Vim][create_spellfile].

### Further Reading

* [`:help spell`][spellchecking]
* [`:help 'spell'`][spell]
* [`:help ]s`][next]
* [`:help [s`][prev]
* [`:help z=`][suggest]
* [`:help zg`][addword]
* [`:help zw`][removeword]
* [`:help spelllang`][lang]
* [`:help spellfile`][spellfile]
* [`:help spellfile-cleanup`][cleanup]

[spellchecking]: http://vimdoc.sourceforge.net/htmldoc/spell.html#spell
[spell]: http://vimdoc.sourceforge.net/htmldoc/options.html#%27spell%27
[next]: http://vimdoc.sourceforge.net/htmldoc/spell.html#]s
[prev]: http://vimdoc.sourceforge.net/htmldoc/spell.html#[s
[suggest]: http://vimdoc.sourceforge.net/htmldoc/spell.html#z=
[addword]: http://vimdoc.sourceforge.net/htmldoc/spell.html#zg
[removeword]: http://vimdoc.sourceforge.net/htmldoc/spell.html#zw
[lang]: http://vimdoc.sourceforge.net/htmldoc/options.html#'spelllang'
[spellfile]: http://vimdoc.sourceforge.net/htmldoc/options.html#'spellfile'
[cleanup]: http://vimdoc.sourceforge.net/htmldoc/spell.html#spellfile-cleanup
[create_spellfile]: http://henry.precheur.org/vim/create_spell_file_for_vim
