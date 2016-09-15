# DOTMATRIX

Dotmatrix is a collection of dotfiles used at Hashrocket to customize various
development tools. This project is the culmination of many years worth of
tinkering with our favorite tools to get them to behave just right. We think
using Dotmatrix makes working with these tools more pleasant and hope you will
too!

## What are dotfiles?

[Dotfiles][wikipedia] are really just plain text files that start with a '.' and
they are used to set preferences for things like Git and Vim. To see your
current dotfiles, open a terminal and in your home folder run this:

[wikipedia]: https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory

```
$ ls -a
```

Most users will see a long list of files that you might not have know were even
there! Since they start with a '.' the OS ignores them (usually) - those are
your current dotfiles, Dotmatrix hopes to replace/augment whatever configuration
you already have.

## Install

Start by cloning down the repo:

```
$ git clone https://github.com/hashrocket/dotmatrix.git
```

Then run this script:

```
$ bin/install
```

This script symlinks all dotfiles into your home directory.

### Hashrocket Workstation

Dotmatrix comes with gitconfig for our Hashrocket Workstations that can be
installed like so:

```
$ bin/install --workstation
```

## Safe by Default

When you install Dotmatrix like this, only files that do not already exist in
your $HOME directory will be linked. If you have your own .bashrc file, for
example, Dotmatrix won't mess with it.

What we'd recommend, however, is moving that file to `~/.bashrc.local`, and
Dotmatrix will source it for you.

## Partial Installation

Sometimes it's useful to only install part of Dotmatrix. For partial
installation, you can create a `FILES` file in the root of Dotmatrix that
contains a newline-delimited list of dotfiles to symlink and keep up to date
with Dotmatrix.

When `FILES` exists in the Dotmatrix source directory, running `bin/install`
will only symlink the dotfiles listed within `FILES`.

If, for example, you only want the tmux configuration and sharedrc files, and
want to ignore all of the rest of Dotmatrix's dotfiles:

```
$ cd path/to/dotmatrix
$ cat FILES
.tmux.conf
.sharedrc
$ bin/install # Only installs .tmux.conf and .sharedrc
```

## Vim bundles

For Vim users, there's another command you might want to run, after you've run
`bin/install`:

```
$ hr vimbundle
```

This will install the set of Vim bundles we use.

After you've done `./bin/install`, you'll have a `.vimbundle` file and this is a
manifest of sorts that the `vimbundles.sh` script will use to install various
vim plugins. If you have other plugins that you like that aren't on this list,
you can put them in a `~/.vimbundle.local` and that will be installed
secondarily.

The `~/.vimbundle.local` file should include one plugin per line, each having
the following format:

```
github-user/repo-name
```

You need not include a trailing `.git`.

## hr

`hr` is a command with lots of useful scripts as subcommands, based loosely on
Basecamp's [sub][sub].

[sub]: https://github.com/basecamp/sub

When you run `bin/install`, `hr` is installed automatically. If you don't want
it, simply comment out the line from `~/.zshrc.local` or `~/.bashrc.local` that
initializes it.

To use, just run `hr`. Each subcommand is self-documenting.

### hr plugins

If you have have commands you'd like to add to `hr`, add them within a "plugin".
Plugins are really just folders within hr's "plugins" folder.

The anatomy of a plugin follows:

```
<root>/
  libexec/
    hr-my-awesome-command
    hr-my-other-command
```

With the above plugin, `hr my-awesome-command` would run the script located at
`hr-my-awesome-command`.

Plugins are designed to be git repos. For example, if there were another hr
plugin you wanted to add, you could add it like this:

```
$ hr plugins add my_plugin git://github.com/path/to/git/repo.git
```

For more information, run `hr help plugins`

## Actively Maintained

At Hashrocket we use Dotmatrix on all of our development machines, then for many
of us we get so familiar with the setup that we use it on our personal machines
too. That means there's a lot of picky nerds using Dotmatrix every day to make
their tools easy and fun to use.

## Update

Keeping your Dotmatrix up-to-date is easy. Just visit the Dotmatrix directory
and run `bin/upgrade`. This will fetch the latest changes from GitHub and
symlink any new files.

## About

[![Hashrocket logo](https://hashrocket.com/hashrocket_logo.svg)](https://hashrocket.com)

Dotmatrix is supported by the team at [Hashrocket, a multidisciplinary design
and development consultancy](https://hashrocket.com). If you'd like to [work
with us](https://hashrocket.com/contact-us/hire-us) or [join our
team](https://hashrocket.com/contact-us/jobs), don't hesitate to get in touch.
