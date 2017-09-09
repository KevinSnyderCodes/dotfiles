# dotfiles
A personal collection of dotfiles for various programs.

![You're the king of your castle](https://raw.github.com/kevipapo1/dotfiles/master/king-castle.png)

- [Features](#features)
- [Installation](#installation)

## Features

- Bash:
  - Aliases for commands and directory traversal
  - `git` aliases
  - Functions: `convert` and `extract`
  - Confirmation when moving, copying, or removing files
- Vim:
  - Syntax highlighting
  - Line numbers
  - Highlight matching brackets
  - Search as characters are entered and highlight matches

## Installation

```shell
$ git clone https://github.com/kevipapo1/dotfiles ~/.dotfiles
$ cd ~/.dotfiles
$ chmod +x setup.sh
$ ./setup.sh
```

Where sensible, `setup.sh` preserves dotfiles that already exist and adds new contents to the beginning of those files so that existing configurations are not overridden.

The file structure below indicates what files are created and modified when running `setup.sh`. Files in bold are overwritten entirely:

<pre>
~
│   .bash_profile
│   .bashrc
│   <em>.vimrc</em>
</pre>

Contents added to dotfiles by `setup.sh` are wrapped in special comments (example below). Feel free to make changes outside of these sections, but **do not remove the comments** as they enable you to upgrade your dotfiles when a new version of the script is released.

```shell
# BEGIN dotfiles
...
# END dotfiles
```