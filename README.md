# hr

A collection of useful scripts, based loosely on 37signals' sub

## Installation

This will set up the hr command and completions:

    hclone hr
    ./bin/hr init
    # follow instructions

Alternatively, if you feel icky about `eval`, assuming that `$HOME/bin`
is in your `$PATH`:

    hclone hr
    mkdir -p $HOME/bin
    ln -nfs $PWD/bin/hr $HOME/bin/hr

## Usage

Just run `hr`. Each subcommand is self-documenting.
