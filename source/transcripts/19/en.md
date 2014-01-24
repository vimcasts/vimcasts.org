Using a spell checker is a good habit to get into.  In this episode, I'll demonstrate how to use Vim's built in spell checking feature

Usage
=====

To enable spell checking in Vim, run the command `:set spell`. This will cause misspelled words to be highlighted. 

The command `]s` will advance your cursor to the next spelling mistake. You can also reverse to the previous mistake by issuing `[s`. When the cursor is on a misspelled word, you can bring up a list of suggested corrections by issuing the command `z=`. The prompt at the bottom of the window instructs you to enter a number followed by the enter key. In this case, the first suggestion is the one I want to use, so I type `1<CR>` 'one-enter' and I'm brought straight back to my document with the correction applied.

If you feel confident that the first suggested correction will be the one you want, then you can bypass the list of suggestions by prepending a count to the `z=` command. So running `1z=` will switch the misspelled word under the cursor with the first suggestion, without even showing you the list. If you are unhappy with the result, you can always hit the `u` key to undo the change.

Setting the wordlist
====================

You can set the language of Vim's spelling dictionary with the `spelllang` option. The default value is `en`, for English. 

I have created two files here, one using British spellings, and the other using American spellings. Spell checking is enabled, but as you can see there is no indication that any words have been misspelled. 

Now if I set the spelllang for each window to British English:

    :windo set spelllang=en_gb

You can see that the American words are highlighted with a blue underscore. This indicates that the word does not belong in the currently selected region, but it is a correct spelling in another region of the same language.

If I set the `spelllang` to American English:

    :windo set spelllang=en_us

The British spellings are now highlighted as being from another region.

Note that the spelllang option can be set for each buffer. So if I make the British version the active window and run:

    :set spelllang=en_gb

Then British English will apply to that window, while the other window continues to use American English. If you want to apply a setting to all windows in the current tab page, you can prepend the command with `windo`. 

Customizing the word list
-------------------------

You can supplement the list of accepted words in a couple of ways. Words marked as misspelled can be added to an internal white list, which will only last as long as your editing session, or saved to a file which means that they will persist for subsequent editing sessions. Here, I'm going to focus on adding words in such a way that they persist.

In addition to the wordlist for the selected language, Vim will also allow words that appear in the spellfile. You can set the path to a spellfile explicitly if you want, but the default option is sensible enough. The filename of the spellfile comprises the language, for example `en` for English, and the encoding.

    ~/.vim/spell/LANGUAGE.ENCODING.add

If you don't already have a `spell` subdirectory in your `.vim` folder, Vim will create it as needed. 

    API
    hashtag
    app
    cron
    
Here is word that is marked as misspelled, but which I want to leave as it is. I can mark this as a 'good' word by running the command:

    zg

As you can see, this adds the word to my spellfile, and it is no longer highlighted as misspelled.

It is also possible to mark good words as being misspelled, by running the command:

    zw

As you can see, this adds the word to my spellfile with a trailing flag to indicate that it is a bad word, and it is now highlighted as being misspelled.

Of course, there is always the risk that you might add entries to your spellfile by accident, so Vim provides an undo feature for both adding and removing words. If I run `zuw` with the cursor on this word, it is restored as a good word. If I move the cursor back to the word which I added to the spellfile, I can run `zug` to remove it, and now it is marked as a spelling error once again.

As you can see, the words have been commented out from the spellfile, but not removed. If this file becomes too large, you can clean it up by running the command:

    :runtime spell/cleanadd.vim

This will strip out all words that have been commented out.

VIMRC
=====

I prefer to treat spell-checking as a separate task from writing, so I like to be able to quickly toggle the spell checker on and off. I keep the following lines in my .vimrc:

    " Toggle spell checking on and off with `,s`
    let mapleader = ","
    nmap <silent> <leader>s :set spell!<CR>

    " Set region to British English
    set spelllang=en_gb

This enables me to quickly toggle the spell checking feature on and off by pressing `,s` in normal mode.

Additionally, I have set the default region to British English. 
