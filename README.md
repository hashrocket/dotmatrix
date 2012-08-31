DOTMATRIX
=========

Dotmatrix is a collection of dotfiles used at Hashrocket to customize various deveopment tools. This project is the culmination of many years worth of tinkering with our favorite tools to get them to behave just right. We think using dotmatrix makes working with these tools more pleasant and hope you will to!

What are dotfiles?
------------------

Dotfile are really just plain text files that start with a '.' and they are used to set preferences for things like Git and Vim. To see your current dotfiles, open a terminal and in your home folder run this:

	$ ls -a


Install
-------

Start by cloning down the repo:

	$ git clone git@github.com:hashrocket/dotmatrix.git

Then run this script:

	$ bin/hlink

This script symlinks all dotfiles into your home directory.

**Please note:** running this command will clobber any dotfiles you already have. If you want to keep your files, back them up and create local versions where supported.

Vim bundles
-----------

For Vim users, there's another script you might want to run:

	$ bin/vimbundles.sh

This will install the set of Vim bundles we use.

Actively Maintained
-------------------

At Hashrocket we use dotmatrix on all of our development machines, then for many of us we get so used to the setup that we use it on our personal machines too. That means there's a lot of picky nerds using dotmatrix every day to make their tools easy and fun to use.

Update
------

Keeping your dotmatrix up-to-date is easy, you just pull down the latest changes in the repo and then run the same install scripts.
