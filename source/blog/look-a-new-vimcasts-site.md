---
:title: Look! A new Vimcasts site
:date: 2014/04/28
:tags: meta
---

Today I'm rolling out some major enhancements to the Vimcasts.org website. 
I've been working on this project with [Hannah Adcock][] since January.
If you're reading this via RSS, why not click through to [the new homepage](http://vimcasts.org) and check it out?

READMORE

### Responsive, categorised, and searchable

The site is now responsive, so it should look good on smartphones and tablets as well as desktop browsers.
To make it easier to find relevant content from the archives, I've [categorised all screencasts and articles](/categories).
I've also added a site-wide search feature, which lets you find material from shownotes and blog posts without having to check Google.

Before making any changes to the site, I asked for feedback from my readers.
You can follow [a detailed breakdown of responses to the survey][survey] on the Contented Strategy Blog.
Some of you thought that the Vimcasts.org site was fine and needed little in the way of changes.
Keeping that thought close, I've taken care to preserve the style of the old site.
If you look at the site with a large screen, you won't see many changes.
I've tried to adapt that style and make it work for smaller format screens as well.

### More than a redesign

I've migrated the site from Radiant CMS to [Middleman][], a static site generator.
It was a big job and it's quite possible that I've broken things that previously worked fine.
If you notice any problems, please email me: [drew@vimcasts.org](mailto:drew@vimcasts.org)
(You can view the old site at [legacy.vimcasts.org](http://legacy.vimcasts.org). I'll keep it up for a few more weeks.)

There are still a few rough edges, which I'll be smoothing out over the coming weeks. 
Now that I've shipped this new version of the site, I can get back to making screencasts about Vim. Watch this space...

### Nitty details

I'm using [Zurb Foundation][] with SCSS.
Site search is provided by [Swiftype][].
The Vimcasts logo is now in SVG format, so it looks crisp across all screen resolutions.
The site is hosted on [Github Pages][pages] and you can [view the source code][source] on GitHub.

[Middleman]: http://middlemanapp.com/
[Zurb Foundation]: http://foundation.zurb.com/
[survey]: http://contentedstrategy.com/blog/2014/01/27/Redesigning-Vimcasts-The_User_Survey.html
[pages]: https://pages.github.com/
[source]: https://github.com/vimcasts/vimcasts.org
[Swiftype]: https://swiftype.com/
[Hannah Adcock]: http://contentedstrategy.com
