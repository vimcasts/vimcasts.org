--- 
:title: VimGolf - Prime Numbers
:date: 2012/08/10
:tags: vimgolf
:poster: /images/posters/primes.png
:flattr_id: "829342"
:duration: 413
:number: 36
:ogg: 
  :url: http://media.vimcasts.org/videos/36/primes.ogv
  :size: 7335704
:quicktime: 
  :url: http://media.vimcasts.org/videos/36/primes.m4v
  :size: 11512378

---

For the VimGolf challenge ["List the first 100 prime numbers"][primes], there's a solution that uses a regular expression to detect prime numbers. At 43 keystokes, it's not the winning solution, but I think it's the most interesting one. It uses a few clever Vim tricks, including macros, control-a to increment, the very magic pattern switch, and the `:global` command. There's a lot to learn from those 43 keystrokes, so let's study it!

[primes]: http://vimgolf.com/challenges/4d1c27940e3d7832db000010

READMORE


Here's the full solution (with a running keystroke tally):

<table>
   <tr>
       <th>keystrokes</th>
       <th>tally</th>
   </tr>
   <tr>
       <td><code>C&lt;Tab&gt;1&lt;Esc&gt;</code></td>
       <td>4</td>
   </tr>
   <tr>
       <td><code>qw</code></td>
       <td>2</td>
   </tr>
   <tr>
       <td><code>&lt;C-a&gt;</code></td>
       <td>1</td>
   </tr>
   <tr>
       <td><code>&gt;&gt;</code></td>
       <td>2</td>
   </tr>
   <tr>
       <td><code>Yp</code></td>
       <td>2</td>
   </tr>
   <tr>
       <td><code>q</code></td>
       <td>1</td>
   </tr>
   <tr>
       <td><code>540@w</code></td>
       <td>5</td>
   </tr>
   <tr>
       <td><code>:g/\v^(&lt;Tab&gt;&lt;Tab&gt;+)\1+&lt;/d|%s/&lt;Tab&gt;*&lt;CR&gt;</code></td>
       <td>24</td>
   </tr>
   <tr>
       <td><code>ZZ</code></td>
       <td>2</td>
   </tr>
   <tr>
       <td><strong>total:</strong></td>
       <td>43</td>
   </tr>
</table>

The `<Tab>` notation stands for the tab key, and `<Esc>` for the escape key. `<C-a>` stands for ctrl-a, and `<CR>` for carriage return, a.k.a. the enter key.
  
Try it out for yourself, and see if you can figure out how it works. You might consider the following explanation a spoiler.

### Strategy

Here's the general strategy: we'll start by inserting the numbers 2, 3, 4, 5, and so on, up to 541, which is the one-hundredth prime number. Having inserted all of the numbers in this range, one per line, we'll then delete each line that contain a non-prime number. That should leave us with the first 100 prime numbers, and nothing else.

And here's the trick: we'll indent each line by a number of tabs that equals the value of the number on that line. For example, the line containing the number 2 will lead with 2 tab characters. The line containing the number 3 will lead with 3 tab characters. And so on. Then we can examine the length of the string with a regular expression.

### Insert numbers 2 up to 542

Combining the [`ctrl-a`][] command with a macro lets us rapidly insert the numbers from 2 up to 542:

<table>
   <tr>
       <th>keystrokes</th>
       <th>explanation</th>
   </tr>
   <tr>
       <td><code>C&lt;Tab&gt;1&lt;Esc&gt;</code></td>
       <td>insert a tab followed by 1</td>
   </tr>
   <tr>
       <td><code>qw</code></td>
       <td>start recording</td>
   </tr>
   <tr>
       <td><code>&lt;C-a&gt;</code></td>
       <td>increment the number</td>
   </tr>
   <tr>
       <td><code>&gt;&gt;</code></td>
       <td>insert a tab at the start of the line</td>
   </tr>
   <tr>
       <td><code>Yp</code></td>
       <td>duplicate the line</td>
   </tr>
   <tr>
       <td><code>q</code></td>
       <td>stop recording</td>
   </tr>
   <tr>
       <td><code>540@w</code></td>
       <td>execute the macro 540 times</td>
   </tr>
</table>

### Delete all non-prime numbers

The `:g/{pattern}/[cmd]` command allows us to execute the specified [cmd] on every line that matches the specified `{pattern}`. It can be used in this form to delete all non-prime numbers:

    :g/\v^(<Tab><Tab>+)\1+</d

Then we can flatten the remaining indentation with this substitute command:

    :s/<Tab>*

Note that these two individual Ex commands can be combined into a single command-line, which saves a keystroke (this is VimGolf remember!):

    :g/\v^(<Tab><Tab>+)\1+</d|s/<Tab>*

### How does that regular expression work?

The magic of the regex happens in this bit:

    (<Tab><Tab>+)\1+

Inside the parentheses, we match two or more tab characters. These are captured in a sub-match, and we can reference this sub-match using the `\1` notation. This bit of the pattern matches one or more occurrences of the original sub-match.

The `+` operator means "one or more" occurrences, and it performs a greedy match. That means it matches as many characters as it can. This diagram demonstrates how the regular expression inspects a string of 8 tab characters:

![The regex finds that 4 is a factor of 8](/images/blog/regex-nonprime-8.png)

The match indicates that 4 is a factor of 8, and therefore 8 is not a prime.

This diagram demonstrates how the same regex interacts with a string of 7 tab characters:

![The regex finds no factors of 7, meaning it's a prime](/images/blog/regex-prime-7.png)

There's no match, which indicates that 7 is a prime number.

<h3 id="credit">Credit where due</h3>

Thanks to [Federicco Galassi][fg] for introducing me to this VimGolf solution. He credited it to [Matthew Draper][matthewd], but Matthew says his solution was a refinement of the one posted by [Glenn][]. That seems to cover the history of this trick since it appeared on the VimGolf site, but the regex that forms the core of this solution has a much longer history.

This Perl one-liner was used in [Abigail's email signature back in 1997][abigail]:

    perl -wle 'print "Prime" if (1 x shift) =~ /^(?!(11+)\1+$)/'

That regex must have gained some notoriety. In this [perlgolf "Sieve of Erastosthenes" challenge][perlgolf] (from 2001), it was referred to as *the infamous RE from Abigail*. I've come across [several][] [explanations][explanation2] of [how the Perl one-liner works][perlexplanation], as well as an article that points out [its limitations][limits].

If you can fill in any more of the details in the history of this solution, please leave a comment below.

### Further reading

* [&lt;C-a&gt;][ctrl-a] to increment a number
* [q{register}][q] to record a macro
* [@{register}][at] to execute a macro
* [\v][vm] the verymagic pattern switch
* [:global][] to perform an Ex command on each line matching a pattern
* [VimGolf: insert the first 100 prime numbers][primes]
* [It's a factor][factor-solution] and an [explanation of the solution][factor]

[primes]: http://vimgolf.com/challenges/4d1c27940e3d7832db000010
[factor]: http://vimgolf.com/challenges/51459ef6b94aa50002000002
[factor-solution]: http://udioica.blogspot.co.uk/2013/11/its-factor-plus-little-prime-numbers.html

[fg]: https://twitter.com/federicogalassi
[matthewd]: https://twitter.com/_matthewd
[Glenn]: https://twitter.com/spamcow_moo
[abigail]: http://diswww.mit.edu/bloom-picayune.mit.edu/perl/7588
[perlgolf]: http://www.perlmonks.org/?node_id=81695
[perlexplanation]: http://pages.cs.wisc.edu/~psilord/blog/9.html
[explanation2]: http://www.catonmat.net/blog/perl-regex-that-matches-prime-numbers/
[limits]: http://zmievski.org/2010/08/the-prime-that-wasnt

[ctrl-a]: http://vimdoc.sourceforge.net/htmldoc/change.html#CTRL-A
[q]: http://vimdoc.sourceforge.net/htmldoc/repeat.html#q
[at]: http://vimdoc.sourceforge.net/htmldoc/repeat.html#@
[vm]: http://vimdoc.sourceforge.net/htmldoc/pattern.html#/\v
[:global]: http://vimdoc.sourceforge.net/htmldoc/repeat.html#:g
