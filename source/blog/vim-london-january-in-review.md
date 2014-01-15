--- 
:title: Vim London January in review
:date: 2013/01/31

---

On Tuesday, 29th January, we held the 3rd meeting of Vim London. We had 5 short talks on the theme of [Speak Vim - operators and motions][meetup]. The talks weren't recorded, so I'm posting a retrospective here.

[meetup]: http://www.meetup.com/Vim-London/events/97866502/


READMORE

We had five short talks, which I'll summarize briefly here:

###1. Vim Grammar, by Tom Cammann

Tom Camman kicked off the evening with an introduction to [Vim's Grammar][grammar]. He illustrated Vim's Normal mode operations with a simple set of rules:

<a href="http://takac.github.com/assets/grammar-slide.html"><img src="/images/blog/vim-grammar.png"/></a>

Check out his [grammar slide][slide] and be sure to click the 'Show optional' link. Tom has written up an [Intro to Vim grammar][grammar] blog post, which nicely summarizes the material from his talk.

[grammar]: http://takac.github.com/2013/01/30/vim-grammar/
[slide]: http://takac.github.com/assets/grammar-slide.html

###2. When and why you should stay out of visual mode, by Drew Neil

I've published the [slides for my presentation][drew-slides] on speakerdeck.

<script async class="speakerdeck-embed" data-id="871a0d204ced0130735122000a8d8021" data-ratio="1.33333333333333" src="//speakerdeck.com/assets/embed.js"></script>

In a nutshell: visual mode doesn't work well with the dot command. The dot command repeats your last change, which allows for a very efficient workflow when going through a set of similar changes. When performing a repetitive set of changes (where the dot command is your friend), you should prefer using Normal operations over Visual operations.

This will be a familiar refrain if you've ever attended one of my Vim Masterclasses. I also cover this material in tip 23 of [Practical Vim][pv]. Essential further reading: [Operator, the true power of Vim][op], by Kana Natsuno.

[drew-slides]: https://speakerdeck.com/nelstrom/when-and-why-you-should-stay-out-of-visual-mode
[pv]: http://pragprog.com/book/dnvim/practical-vim
[op]: http://whileimautomaton.net/2008/11/vimm3/operator

###3. Meet Easymotion, by Jack Franklin

Jack presented a lightning talk on the [easymotion][] plugin by Kim Silkebaekken. He gave a live demonstration (no slides) of how the plugin allows you to rapidly move around a file. He also mentioned that his [Beginning jQuery][] book was due to be released the next day. Congratulations to Jack on becoming a published author! (I'll show you the secret handshake next time we meet)

[easymotion]: https://github.com/Lokaltog/vim-easymotion
[Beginning jQuery]: http://www.apress.com/9781430249320

###4. Meet Surround, by Kris Jenkins

Kris presented a lightning talk on [surround][], an essential plugin from Tim Pope. Kris gave a live demonstration of some of the scenarios where the plugin can make life easier. You can find his [demo files][surround-demo] github. He also explained the way that surround fits in with Vim's existing grammar rules.

[surround]: https://github.com/tpope/vim-surround
[surround-demo]: https://github.com/krisajenkins/surround

###5. Custom motions in Vim, by Alex Young

Alex closed the evening with a look at how to create custom motions using Vimscript. He's [published his slides][alex-slides] on speakerdeck:

<script async class="speakerdeck-embed" data-id="2f5cb0004cf9013041a3123139281814" data-ratio="1.2994923857868" src="//speakerdeck.com/assets/embed.js"></script>

Alex introduced the concept of operator-pending mode, and showed how `:omap` can be used to create motions that work in that mode. As case studies he looked at the [camelcasemotion][] and [seek][] plugins, discussing how they were implemented.

[alex-slides]: https://speakerdeck.com/aryoung/vim-london-custom-motions
[camelcasemotion]: http://www.vim.org/scripts/script.php?script_id=1905
[seek]: https://github.com/goldfeld/vim-seek
[instict]: http://usevim.com/2013/01/30/instinct/

###More

[Inspired by the meetup][tweet], Rob Miller published a new custom motion of his own: [movar][], which makes it easy to operate on variables in (so far) PHP, Javascript, and Ruby. Check it out!

[tweet]: https://twitter.com/robmil/status/296658616088395779
[movar]: https://github.com/robmiller/vim-movar

###Up next...

Vim London will meet again in February, on the last Tuesday of the month. We haven't picked a theme yet, but if you'd like to be involved in the discussion, then please join the [Vim London google group][group].

It's disappointing that we didn't manage to record the talks this time around, but I hope to figure something out in time for the next meetup. If you can help, I'd love to hear from you.

[group]: https://groups.google.com/forum/?hl=en&fromgroups#!forum/vimlondon
