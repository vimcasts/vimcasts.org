# :Abolish - abbreviations on steroids

## Meet Vim's abbreviations

Vim has a built-in feature called *abbreviations*, which can provide autocorrect functionality. I frequently mistype the word 'the' as 'teh'. To correct this typo, we could create an abbreviation using the `iabbrev` command:

    :iabbrev teh the

Now when I type 'teh', it should automatically be changed to 'the' when I press space.

Actually, the abbreviation is triggered by any keystroke that ends the word, including punctuation marks and newlines:

    teh, teh<CR>

The abbreviation is not triggered if the sequence of characters form the start of a longer word. For example, if I were to type the name of the capital city of Iran, the abbreviation won't kick in:

    tehran

In that sense, abbreviations are pretty smart. But they have their limits. If I happen to make this typo at the start of a sentence, the abbreviation won't kick in:

    Teh capital of Iran is Tehran.

Abbreviations are case sensitive, so if I wanted to be thorough I would have to define more than one such mapping for every word that I wanted to auto-correct.

    :iabbrev teh the
    :iabbrev Teh The
    :iabbrev TEH THE

The abolish plugin, by Tim Pope, provides a solution for this. It includes a smart command called `:Abolish`, which has a similar form to the built-in `iabbrev` command. 

    :Abolish teh the

This single command generates these three different variations in one go. I'll source this file to execute that command. 

We can inspect the list of abbreviations by running the command:

    :abbreviate

As you can see, we now have abbreviations that correct 3 case-variations of the same misspelling.

## Patterns

Abolish can also define multiple abbreviations based on a list of comma-separated alternatives. Take the word `color`, for example. I tend to use the British spelling, but I'm often required to use the American spelling. So let's create an abbreviation for it:

    Abolish colour color

I'll source this file to execute that command, and now when I enter the British spelling of 'colour' it's changed to the American spelling. But the abbreviation doesn't apply when I write 'colours', 'coloured', or 'colouring', and so on.

We can tack these suffixes on at the end of the word, as a comma-separated list within a pair of braces. We could spell out the same list of suffixes on the right-hand side too, but an empty pair of braces has the same effect:

    :Abolish colour{,s,ed,ing} color{}

Let's source the file again. Now Vim will auto-correct all of the variations of the word `colour` that we specified. Here's the full list of abbreviations:

    :abbreviate

The word 'honour' follows a similar pattern. The British spelling includes the letter 'u', whereas the American spelling does not. We could adapt our command to generate abbreviations for honor as well as color:

    :Abolish {col,hon}our{,s,ed,ing} {}or{}

Source the file, and now look at our list of abbreviations. It's huge! We generated all of that from these two commands.

The Abolish command is really handy if you want to auto-correct the words that you frequently mis-spell. I've put together a plugin that generates abbreviations for converting lots of British spellings to the American equivalents. I'd be interested to hear of any other uses that you find for this feature.
