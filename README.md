# hr

A collection of useful scripts, based loosely on 37signals' sub

## Installation

Before you do anything, you should *remove* the file that dotmatrix symlinked
for you. It is old, broken, and defunct:

    [ -f ~/bin/hr ] && rm ~/bin/hr

This will set up the hr command and completions:

    hclone hr
    ./bin/hr init
    # follow instructions, adding the line to either .bashrc.local or .zshrc.local

## Usage

Just run `hr`. Each subcommand is self-documenting.
