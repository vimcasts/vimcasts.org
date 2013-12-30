---
title: Using Vim's paste mode with the system paste command
date: 2013/11/15
---

When Vim is compiled without the `+clipboard` feature, we can still insert text from the clipboard using the system paste command (`ctrl-v` or `cmd-v`). This can produce strange effects, but we can avoid them by toggling the `paste` option each time we use the system paste command.
