Create a dotvim repository
--------------------------

Typically, your vim configuration is held in a hidden file named "dot-vimrc" in your home directory. If you want to make any customisations for graphical Vim, you can keep those in a file named "dot-gvimrc". Additionally, you can keep plugins, colorschemes and other scripts in a hidden directory named "dot-vim".

To keep all of these items under version control, I'm going to begin by moving my vimrc and gvimrc files into the dotvim directory. I have chosen to rename them without a leading dot, which means that they won't be hidden inside the dotvim directory.

    mv ~/.vimrc ~/.vim/vimrc
    mv ~/.gvimrc ~/.vim/gvimrc

When Vim starts up, it is still going to look for a file called `.vimrc` in the home directory. I want it to read the vimrc file inside my dotvim directory, so I'll create a symbolic link to that file. I'll do the same thing for the gvimrc file too.

    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc

Finally, I want to turn the dotvim directory into a git repository. I'm going to create a README file, which will include simple instructions on how to install these Vim configuration files on any machine that has git installed.

    cd ~/.vim
    git init
    vim README
    " Paste instructions for symlinking .vimrc/.gvimrc

I'll commit these changes, and now my repository is ready to publish.

    git add .
    git commit -m 'Initial commit'

Publish to github
-----------------

I recommend publishing your configuration files to github. It's really easy to set up an account, and they will host your open source projects for free.

Here, I've signed in to github, and on the homepage I click the "New repository" button. I'm going to call this repository "dotvim". When I click the "Create repository" button, github provides precise instructions on how to get started. The instructions are tailored to my situation, so I can copy and paste them directly into the Terminal. After pushing the repository, I can click the "continue" link to view the new homepage for this project. Note that the README file is listed on the homepage.

Synchronise your changes to another machine
-------------------------------------------

Having published my dotvim repository to github, I'm now going to show how easy it is to synchronise my configuration to another machine. Here, I've got a fresh install of Ubuntu running as a virtual machine. I've already installed the git and vim packages.

The README file that I created earlier includes all of the instructions that I need, so I'll just follow these. I begin by cloning the git repository to my home directory:

    git clone http://github.com/nelstrom/dotvim.git ~/.vim

Then I create symbolic links for `.vimrc` and `.gvimrc` files:

    ln -s ~/.vim/vimrc ~/.vimrc

Now, when I launch Vim, it should load all of the configuration settings that I have saved in my dotvim files.

Make a change to the vimrc file
-------------------------------

Back in my local machine, I'm now going to create a new command in my vimrc. It simply prints some text at the bottom of the screen:

    command! Status echo "All systems are go!"

Having saved this change, I then commit it to my git repository, and push to github.

    # On mac:
    git commit -cm "Add a Status command"
    git push

Back on the linux machine, I can now fetch the latest version from github:

    git pull

When I launch Vim again, I should have access to the new `:Status` command.

Version control your plugins
============================

The traditional method for installing Vim plugins is to copy each script that is distributed with the plugin into the corresponding `.vim` subdirectory. For example, if you wanted to install Fugitive.vim (a git wrapper for Vim), you would copy the documentation file into `.vim/doc`, and copy the plugin file into `.vim/plugin`. You could then check these in to your git repository, and they could be syncronised across machines as easily as the rest of your configuration files. But you lose something by doing this. The Fugitive plugin itself is kept under version control with git. It would be much better if you could keep it that way.

Install pathogen.vim
--------------------

The pathogen plugin makes it possible to cleanly install plugins as a bundle. Rather than having to place all of your plugins side by side in the same directory, you can keep all of the files for each individual plugin together in one directory. This makes installation more straightforward, and also simplifies the tasks of upgrading and even removing a plugin if you decide you no longer need it.

To install Pathogen, download the script and place it in your `.vim/autoload` directory (if the directory doesn't exist, you'll have to create it).

There are a couple of lines that you should add to your .vimrc file to activate pathogen.

    call pathogen#runtime_append_all_bundles()
    call pathogen#helptags()

It is essential that these lines are called before enabling filetype detection, so I would recommend putting them at the top of your vimrc file. 

Install plugins as git submodules
---------------------------------

With pathogen installed, it's now possible to keep the files for each plugin together, which means that every plugin can be kept in its own git repository. The best way to do this is to use git submodules, which are designed especially for the purpose of keeping git repositories within a git repository.

I'll demonstrate how to install the Fugitive plugin as a submodule, then I'll show how to synchronise those changes on to my Ubuntu setup.

First, I'll navigate to the root of my dotvim git repository.

    cd ~/.vim

From github, I'll copy the URL for the fugitive plugin. This is exactly the same URL that you would use if you were going to clone the repository. But instead, I'm going to add it as a submodule. The command goes:

    git submodule add http://github.com/tpope/vim-fugitive.git bundle/fugitive

    git submodule add URL_for_repository local_path_to_bundle

This command clones the git repository to the specified path, whilst instructing the dotvim repository to treat the plugin as a submodule. A new hidden file called `.gitmodules` is created in the root of the current repository. This file contains information about this and any other submodules.

Note that the repository is called "vim-fugitive", which is sensible because it makes it more visible to anybody searching github for Vim plugins. But I've decided to remove the "vim-" prefix when copying it locally, because the context makes it clear that it is a vim bundle.

Having installed the Fugitive plugin, I now want to commit the change, and push to github.

Synchronise plugins to another machine
--------------------------------------

Now I'll show you how to synchronise my submodules to another machine. Switching back to Ubuntu, I'll change to the dotvim repository, and pull the latest changeset. 

    cd ~/.vim
    git pull

If I run `git log`, you should see that it matches the most recent commit that I pushed from my other machine. 

At the moment, the `bundle/fugitive` directory exists, but it contains no files. 

Running:

    git submodule init

registers the submodule, then running:

    git submodule update

Checks out the version of the Fugitive repository that was committed to the dotvim repository.

It might look like a lot of work for just synchronising a single plugin. But if I had installed 20 Vim bundles as git submodules, I would still only have to run the same two commands: `git submodule init`, then `update`, and all of the bundles would be copied over.

Summary
=======

Once your vim configuration is under version control, it's quite straightforward to import your settings to any machine that has git installed. To recap, here are the commands that I ran on the Ubuntu virtual machine:

    cd ~
    git clone http://github.com/username/dotvim.git ~/.vim
    ln -s ~/.vim/vimrc ~/.vimrc
    ln -s ~/.vim/gvimrc ~/.gvimrc
    cd ~/.vim
    git submodule init
    git submodule update

* From the home directory
* clone my dotvim repository into a ~/.vim directory
* create symlinks for vimrc and gvimrc files
* then from the dotvim directory
* initialize submodules
* and update them

Outro
=====

You can adapt the method demonstrated here to suit your needs. Personally, I use a slightly different approach, which keeps all of my dotfiles (including bashrc, irbrc and so on) under version control in one place. If you have another way of doing it I'd like to hear about it, so leave a comment in the shownotes.

