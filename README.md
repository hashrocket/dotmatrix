DOTMATRIX
=========

Dotmatrix is a collection of dotfiles used at Hashrocket to customize various
development tools. This project is the culmination of many years worth of
tinkering with our favorite tools to get them to behave just right. We think
using dotmatrix makes working with these tools more pleasant and hope you will
too!

What are dotfiles?
------------------

Dotfile are really just plain text files that start with a '.' and they are
used to set preferences for things like Git and Vim. To see your current
dotfiles, open a terminal and in your home folder run this:

	$ ls -a


Install
-------

Start by cloning down the repo:

	$ git clone https://github.com/hashrocket/dotmatrix.git

Then run this script:

	$ bin/install

This script symlinks all dotfiles into your home directory.

**Please note:** This will only install files that do not already exist in your
$HOME directory. If you have, e.g. your own .bashrc file, you can move it to
~/.bashrc.local, and dotmatrix will source it for you.

Partial Installation
--------------------

Sometimes it's useful to only install part of dotmatrix. For partial
installation, you can create a `FILES` file in the root of dotmatrix that
contains a newline-delimited list of dotfiles to symlink and keep up to date
with dotmatrix.

When `FILES` exists in the dotmatrix source directory, running `bin/install`
will only symlink the dotfiles listed within `FILES`.

If, for example, you only want the tmux configuration and sharedrc files, and
want to ignore all of the rest of dotmatrix's dotfiles:

    $ cd path/to/dotmatrix
    $ cat FILES
    .tmux.conf
    .sharedrc
    $ bin/install # Only installs .tmux.conf and .sharedrc

Vim bundles
-----------

For Vim users, there's another script you might want to run, after you've run
bin/install:

	$ bin/vimbundles.sh

This will install the set of Vim bundles we use.

After you've done ./bin/install, you'll have a .vimbundle file and this is a
manifest of sorts that the vimbundles.sh script will use to install various vim
plugins. If you have other plugins that you like that aren't on this list, you
can put them in a ~/.vimbundle.local and that will be installed secondarily.

The ~/.vimbundle.local file should include one plugin per line, each having the
following format:

	github-user/repo-name

You need not include a trailing `.git`.

Actively Maintained
-------------------

At Hashrocket we use dotmatrix on all of our development machines, then for
many of us we get so familiar with the setup that we use it on our personal machines
too. That means there's a lot of picky nerds using dotmatrix every day to make
their tools easy and fun to use.

Update
------

Keeping your dotmatrix up-to-date is easy. Just visit the dotmatrix directory
and run `bin/upgrade`. This will fetch the latest changes from GitHub and
symlink any new files.
