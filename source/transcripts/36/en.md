For the VimGolf challenge "List the first 100 prime numbers", there's a solution that uses a regular expression to detect prime numbers. At 43 keystokes, it's not the winning solution, but I think it's the most interesting one. It uses a few clever Vim tricks, including macros, control-a to increment, the very magic pattern switch, and the `:global` command. There's a lot to learn from those 43 keystrokes, so let's study it!

    C<Tab>1<Esc>
    qw
    <C-a>
    >>
    Yp
    q
    540@w
    :g/\v^(<Tab><Tab>+)\1+</d|%s/<Tab>*
    ZZ

Vimcasts is supported by Xeriom networks. If you need to build a reliable, scalable network that can support your growing business needs, then get in touch with xeriom networks, and be sure to say you heard about them here.

## Strategy

Here's the general strategy: we'll start by inserting the numbers 2, 3, 4, 5, and so on, up to 541, which is the one-hundredth prime number. Having inserted all of the numbers in this range, one per line, we'll then delete each line that contain a non-prime number. That should leave us with the first 100 prime numbers, and nothing else.

The global command will act as our sieve:

    :global/{pattern}/[cmd]

This lets us execute a specified Ex command on every line of the file that matches a particular pattern. In our case, we'll run the `delete` Ex command, for each line that contains a non-prime number:

    :global /{non-prime number}/ delete

For the golfers, note that both `global` and `delete` can be abbreviated to a single character:

    :g/{non-prime number}/d

Writing a pattern that matches non-prime numbers is the clever part. And here's the trick: we'll indent each line by a number of tabs that equals the value of the number on that line. For example, the line containing the number 2 will lead with 2 tab characters. The line containing the number 3 will lead with 3 tab characters. And so on.

## Inserting all numbers from 2 to 541

Starting with a blank document, we'll begin by inserting a single tab, followed by the number 1.

    C<Tab>1<Esc>

Next, we'll start recording a macro into register `w`. The ctrl-a command increments the number on the line, then the `>>` "indent" command adds a tab at the start of the line. Finally, we'll duplicate the line, then stop recording the macro.

    qw
    <C-a>
    >>
    Yp

Now we can execute our macro with a count of 540, which produces all of the numbers from 2 up to 542. It's difficult to see what's happening here, so let's make the tab character visible:

    :set list listchars=tab:▸\ ,eol:¬

And for the sake of clarity, we'll also set the width of a tab to a single column:

    :set tabstop=1

Now you should be able to see that the line containing the number 2 leads with two tab characters, the line containing the number 3 leads with three tab characters, and so on. The general appearance resembles a staircase, which wanders constantly to the right.

## Deleting all non-prime numbers

The next step is to delete all non-prime numbers. It can be done with this one-liner:

    :g/\v^(<Tab><Tab>+)\1+</d|%s/<Tab>*

Did you catch that?

There's a lot going on in that command, so let's undo that change and break it into chunks.

This regular expression does all of the hard work for us:

    /\v^(   +)\1+<
    :set hlsearch

If we search for it, and enable the `hlsearch` option, then we'll see each line containing a non-prime number light up. How does that work?

First of all, note that the pattern begins with `\v` - the very magic switch. Here's the same regular expression without it:

    /\v^\(   \+\)\1\+\<

The very-magic switch allows us to use symbols such as parentheses, word delimiters and the plus symbol without having to escape them. That makes for a neater regular expression.

The less-than sign stands for the beginning of a word, or to put it another way: it stands for the end of the sequence of whitespace characters.

All of the magic happens in this bit in the middle. Inside the parentheses, we match two or more tab characters. These are captured in a sub-match, and we can reference this sub-match using the `\1` notation. This bit of the pattern matches one or more occurrences of the original sub-match.

So we have a pattern that refers to a fragment of itself. What does that mean? To understand, it helps to look at the mechanics of how a regular expression works. We'll run through two examples: first on a non-prime number, then on a prime number.

### Matching 8 tab characters

The `+` operator means "one or more" occurrences, and it performs a greedy match. That means it matches as many characters as it can. In this case, the sub-match expands to all eight tab characters.

But the backreference attempts to match the same range of text again. In this case, there are no more tab characters left, so we don't get a match.

When a greedy match fails, the regular expression engine makes another attempt using a slightly less greedy match. In this case, it attempts to match 7 characters (instead of 8). That creates a submatch of 7 characters, and once again we have no match.

This process continues. We get no match with 6 characters, or 5. When it gets down to 4 tabs, we score a match!

This indicates that the number 8 is divisible by 4, so it's not a prime number.

### Attempting to match 7 tab characters

Now let's run through the same proceedure for the number 7 - a prime.

Once again, the regex engine starts by doing a greedy match, which consumes all available tab characters.

Then the first match contracts to 6 tabs, then 5, then 4, and so on. The regex engine doesn't attempt anything less than two, because that was hard coded in the regular expression.

We can conclude that there is no way of matching 7 tab characters with this pattern. Or in other words, 7 must be a prime number.

### Using the prime-sieve pattern with :global

This same proceedure works for every number in our document. With the search highlighting enabled, you can clearly see which numbers are non-primes. Each line that is highlighted will be deleted when we run the global command:

    :g/\v^(   +)\1+</d

And that leaves us with only the prime numbers.

### Tidying up

As a final step, we want to flatten the indentation. We can do so using this substitute command:

    :%s/<Tab>*//

That matches every sequence of tabs, replacing each one with an empty string. The line numbers show that we have 100 lines, and we know that each one contains a prime number. So we're finished - we've inserted the first 100 primes!

### Outro

The regular expression 

The information in this video is summarized in the accompanying show notes. If you have any questions, requests, or recommendations, or if you would be interested in sponsoring Vimcasts, then you can contact me at drew at vimcasts dot org. 