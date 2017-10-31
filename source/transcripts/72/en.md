Let's run the `:CheckHealth` command to see what happens.

    :CheckHealth
    ## Configuration
      - INFO: found sensible.vim plugin:
      - ERROR: sensible.vim plugin is not needed; Nvim has the same defaults
      built-in. Also, sensible.vim sets 'ttimeoutlen' to a sub-optimal value.
        - SUGGESTIONS:
          - Remove sensible.vim plugin, or wrap it in a `if !has('nvim')` check.

Straight away it uncovers a problem: it advises us that sensible.vim is not needed.
This plugin by Tim Pope aims to specify a universal set of default values for Vim users.
Neovim has adopted these values and made them defaults out of the box, so there's no need to use this plugin.

Let's modify our `vimrc` file, making it skip the `sensible` plugin when running `nvim`:

    if has('nvim')
      let g:loaded_sensible=0
    endif

This lets us continue to use the sensible plugin when we're running Vim.

Let's restart Neovim and run `:CheckHealth` again.

    :CheckHealth

The warning about sensible.vim has gone away.

## Providers

Neovim uses `providers` to implement some features whose behaviour may depend on the system and environement.
Currently Neovim ships with providers for clipboard support, python integration, and ruby integration.

The `:CheckHealth` command runs diagnostics for each provider.
My local `nvim` installation gives you an idea of how things look when all of the providers are correctly configured.
For the sake of comparison, I've set up an Ubuntu machine with a fresh installation of Neovim.

Let's run `:CheckHealth` here...

It looks like we've got a few things to set up.

## Clipboard providers

First up, lets compare the clipboard providers.
In OS ten, we get the message:

> Clipboard tool found: pbcopy

    ## Clipboard
      - SUCCESS: Clipboard tool found: pbcopy

Whereas on Ubuntu we get the message:

> No clipboard tool found.

    ## Clipboard
      - WARNING: No clipboard tool found. Clipboard registers will not work.
        - SUGGESTIONS:
          - See ":help clipboard".

The message points us towards the appropriate help page, which gives us more information.

> Clipboard access is implicitly enabled if any of the following clipboard
> tools are found in your `$PATH`.

Since we're running Ubuntu headless, there's no system clipboard to interact with.
If we were running Ubuntu with a graphical user interface, then we might have access to the `xclip` provider, or possibly the `xsel` provider.
When a suitable provider is available, NeoVim gets clipboard support without any further configuration.

## Python integration

If you want to use plugins that are implemented using python, then you'll need to install the appropriate provider.
Providers are available for both python2 and python3.
`:CheckHealth` points us towards the appropriate help page, where detailed instructions are provided.

    :help provider-python

We need to install the python-client, which is available as a Python package called `neovim`.
We'll go ahead and install it for both python2 and python3.

    $ sudo pip2 install --upgrade neovim
    $ sudo pip3 install --upgrade neovim

Now when we run the `:CheckHealth` command, we get the 'Success' message for each of our python providers.

## Ruby integration

Ruby integration is also handled by a provider.
The ruby-client is available as a gem called `neovim`:

    $ sudo gem install neovim

So let's install the gem...

And now Neovim has ruby integration.

Once again, this step is only necessary if you want to use plugins that are implemented using Ruby.
The `neovim` ruby gem supports *legacy* plugins written using Vim's ruby support, as well as the new remote plugins that use RPC to communicate with Neovim.

## Comparison with Vim

Providers make it possible to dynamically enable functionality in Neovim when the necessary tools are available in the environment.
Contrast this with the approach that Vim takes: where optional functionality can be enabled or disabled at compile time.

The version of Vim that Apple ships with OS ten was compiled without clipboard support.
So if you want Vim with clipboard support on OS ten, you have to either recompile it or reinstall it.

    $ /usr/bin/vim --version
    -clipboard
    -xterm_clipboard
    -python
    +python3
    -ruby

The approach that Neovim takes is more flexible and more convenient for users.
