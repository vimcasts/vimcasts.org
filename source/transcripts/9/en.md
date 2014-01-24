How to use tabs
===============

If you have worked with a tabbed interface in other editors, or IDEs, it will be tempting to assume that Vim's tabs work the same way. But Vim's treatment of tabs is actually quite unusual. 

I'm going to use TextMate to illustrate the difference. Here, as I click on filenames, each one is opened in a new tab. Essentially, TextMate's tabs can be seen as a list of currently open files. 

I'm now going to repeat the exercise in Vim, opening the same 3 files using the `:edit` command. I'm not asking Vim to open each file in a new tab, so instead it just replaces the contents of the current window with the specified file. I can see a list of currently open buffers by issueing the `:ls` command. 

Vim's buffer list is conceptually similar to TextMate's tabs.

Searching for a string
----------------------

To demonstrate how Vim's tabs differ from TextMate's, I'm going to use the example of searching for a pattern within a project.

    Textmate: search for 'C' (files open: [a],b,c), moves to c tab
    Textmate: search for 'D' (files open: [a],b,c), opens & activates d

Here I have a Vim session with files A,B and C each open in their own tab. Now watch what happens when I search for the character C in the current project. Vim doesn't seem to be interested in the fact that file C is already open in a tab of its own. instaed, it jumps straight to the first match in the currently active window. 

    Vim: open tabs: [a],b,c, search for 'c'. [c],b,c - show buffer list

If we look at the buffer list, we can see that files A, B and C are each represented. File C has replaced file A as the active file, but we can easily retrieve the alternate file using the command ctrl-^

File D is not currently open in a buffer. When I search for the character 'D', Vim jumps straight to the first match just as before. Listing the buffers, we can see that file D has been added to the buffer list. 

    Vim: open tabs: [a],b,c, search for 'd'. [d],b,c - show buffer list

Remember that in TextMate, when I searched for the character D, it opened the file in a new tab, whereas Vim opened the file in the currently active window. In both cases, file D was added to the list of currently open files. It just happens that TextMate uses tabs to represent this list, whereas Vim uses the buffer list.

---

In TextMate I can create a new project from a subdirectory by 

Now, when I launch the find in project dialogue and search for the A charcter I don't get any matches. This is because find in project is limited to the scope of the current working directory, and the numbers directory doesn't contain the A character.

Vim's tabs can be treated like TextMate projects. If I issue the command `:pwd` it reveals the path of current directory. When I create a new tab, it automatically inherits the same working directory. But using the `:cd` command, I can change from the characters directory into the numbers subdirectory. 

If I go back to the first tab and issue the `:pwd` command, you can see that it is still in the same directory as we left it. Whereas the new tab has changed to a subdirectory. Just as in TextMate, if I search in the numbers directory for the 'A' character, I find no matches.

In practice, the ability to focus on different working directories per tab can be useful if you are working on a large codebase. For example, in a Rails project, I might use one tab for the root of the application, and create a second tab for working on a plugin. 

---

You can also treat Vim's tabs as groups of windows, each with a particular layout. This is useful if you are working on many files, which can be arranged together into small groups. You can set up a tab with split windows, showing all the files that are relevant to a particular task. With several tabs set up in this fashion, you can work with multiple tasks at once, each with it's own layout.

Vim's tabs are quite unlike those in other editors. The fact that each tab can have its own working directory means that you can focus on different projects per tab. The ability to save layouts of split windows in a tab allows you to arrange related files conveniently together. If you have come to Vim from another editor, I encourage you to try and exploit these features, rather than being frustrated by the otherness of Vim. 
