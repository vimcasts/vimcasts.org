--- 
:title: Habit breaking, habit making
:date: 2013/02/06

---

Moving your Vim cursor around using the arrow keys is a bad habit, and like many bad habits it's a difficult one to break! Putting these lines into your vimrc can help:

    noremap <Up> <NOP>
    noremap <Down> <NOP>
    noremap <Left> <NOP>
    noremap <Right> <NOP>

This snippet causes each of the arrow keys to execute *no operation*, or in other words: it disables them. Next time you move your hand to the arrow keys you'll find that nothing happens when you press them. That should remind you to move your hand back where it belongs: on the home row, where `h`, `j`, `k`, and `l` keys are waiting for you. Alternatively, you could use the [konami code][] version of this snippet.

Learning to operate Vim without leaving the home row is the first rite of passage. If you're still in the habit of moving around using the arrow keys, then you should disable them today.

[konami code]: http://www.tylercipriani.com/vim.html


READMORE

<r:snippet name="announcement"/>

### Stop using the `h`, `j`, `k`, `l` keys!

There's nothing slower than moving one line or column at a time. Vim provides dozens of motions for moving around quickly, so it's no exageration to say that [holding down j is a Vim anti-pattern][long-distances].

Learning Vim is not unlike studying a foreign language, where adding a word to your vocabulary increases the number of things that you can say. It takes time and practice to pick up Vim's motions, but every time you add a motion to your repertoire you'll discover scenarios where it can save you time and keystrokes.

For the sake of learning, let's say that it's a bad habit to use the `h`, `j`, `k`, and `l` motions. In that case, you should disable them by putting this snippet in your vimrc:

    noremap h <NOP>
    noremap j <NOP>
    noremap k <NOP>
    noremap l <NOP>

Not being able to move one line or column at a time will force you to use other motions to get around. If that sounds scary to you, let me introduce a couple of the most useful motions. Learning these won't take a lot of effort, and the payback will be huge.

### Wordwise motions are 5x faster than `h` and `l`

The `w`, `b`, `e`, and `ge` commands allow us to move forward or backward to the start or end of a word. The `W`, `B`, `E`, and `gE` commands do the same for a WORD (see [:help word][] for the difference between words and WORDs). If we say that the average word length is 5 letters, then moving back and forward a word at a time is approximately five times faster than using `h` and `l` to move a character at a time.

Start off by adding `w` and `b` to your repertoire. These move forward and back to the start of a word. When you find yourself wanting to get to the end of a word, add e and ge to your repertoire.

### Character search is near-instant for moving within a line

The `f`, `F`, `t`, `T`, `;`, and `,` commands make up the suite of character search motions. When you press `f{char}`, Vim looks forward from the cursor position for the next occurrence of `{char}` on the current line. If it finds a match, the cursor moves directly there. If no match is found, nothing happens. (Vim might beep at you, but you can mute that by [setting 'visualbell'][vb].)

Try this: in Vim, move your cursor to the beginning of a line with lots of text on it. Look ahead for a character that occurs with low frequency, such as a punctuation mark or uppercase letter. Press `f` followed by the character that you picked. That's two keystrokes. Are you there yet?

If your cursor stopped on a match before the one you were aiming for, press ; to repeat the search. Keep pressing ; until you hit your mark. If you overshoot, press , to reverse the search.

For uncommon characters, you can usually hit your target from a distance with only 2 keystrokes. Common characters aren't such easy targets for this method, so it helps to think like a Scrabble player!

The character search commands allow for efficient navigation within the current line. I use them all the time! If these motions are not a part of your repertoire, then you owe it to yourself to get practicing with them. Character search allows you to move around close to [the speed of thought][oredev-vim].

### Use `h` and `l` for off-by-one errors

Sometimes, I'll accidentally use `f{char}` when I should have used `t{char}`, which places me one character away from where I wanted to be. Or perhaps I'll use `f{char}` to target an uncommon character that's adjacent to the common character I actually want to hit. I refer to these scenarios as off-by-one errors. I consider them to be one of the few occasions where it's acceptable to use the `h` or `l` motion.

### Use `<NOP>` mappings to break bad habits

I'm not really suggesting that you permanently disable the `h`, `j`, `k`, and `l` keys. After all, they're necessary for correcting those off-by-one errors. But if you're having a slow day at work, then disabling `h`, `j`, `k`, and `l` for the afternoon could make things more interesting. If it forces you out of your comfort zone and encourages you to use wordwise motions, character searches, and other motions, then it counts as a useful exercise.

### Meet [hardmode][]

If this sounds like a worthwhile challenge, you might want to install the [hardmode][] plugin (which I heard about from Rob Miller at [Vim London][]). This provides convenience commands for enabling and disabling the `h`, `j`, `k`, `l`, and arrow keys in one go. To disable cursorwise motions, run:

    :call HardMode()

If it gets too difficult, you can wimp out and re-enable these keys by running:

    :call EasyMode()
    You are weak...

[long-distances]: http://vimuniversity.com/samples/jumping-long-distances
[oredev-vim]: http://vimeo.com/53144573
[oredev-slides]: https://speakerdeck.com/nelstrom/vim-precision-editing-at-the-speed-of-thought
[:help word]: http://vimdoc.sourceforge.net/htmldoc/motion.html#word
[vb]: http://vimdoc.sourceforge.net/htmldoc/options.html#'vb'
[hardmode]: https://github.com/wikitopian/hardmode
[Vim London]: http://www.meetup.com/Vim-London/