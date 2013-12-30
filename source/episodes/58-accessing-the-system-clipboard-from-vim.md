---
title: Accessing the system clipboard from Vim
date: 2013/11/11
---

In some environments, Vim lets us access the system clipboard using the quoteplus register, `"+`. When this feature is enabled, we can use it with the delete, yank and put operations in much the same way that we use Vim's other registers. Pasting from this register usually produces better results than using the system paste command in Insert mode.

