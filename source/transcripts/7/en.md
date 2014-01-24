Intro
-----

In Vim, you can view several buffers at once by loading them into multiple windows.
New windows can be created by splitting horizontally and vertically, and Vim ensures that they don't overlap. This is useful when you need to work on several files at once. 

Many of the commands we'll cover in this episode begin with control-w. You can
see the full list of these commands by running `:help ctrl-w`. Note that, for
example, `control-w s` has the same effect as `control-w control-s`. You can use whichever version feels more comfortable to you.

Opening split windows
---------------------

* ctrl-W s
* ctrl-W v
* :sp filename
* :vsp filename
* :q
* :on


Shifting focus between windows
------------------------------

* ctrl-W [wW]
* ctrl-W [hjkl]

These commands are very useful when working with multiple windows. To make them slightly more convenient, I include these lines in my vimrc. This means that instead of running `ctrl-w h`, I now just have to run `ctrl-h`.


Resizing windows
----------------

* ctrl-W [-+]
* Use the mouse!
* ctrl-W =
* ctrl-W \_
* ctrl-W |

Moving windows
--------------

* ctrl-W [rR]
* ctrl-W [xX]
* ctrl-W [HJKL]


# These commands didn't make it into the screencast:
Also:

* :sp #     -   opens the alternate file in a split window
* :vsp #

* :bo sp
* :bo vsp
* :to sp
* :to vsp