#!/bin/bash

# Constants

CONST_WRAP_BEGIN=$'# BEGIN dotfiles\n'
CONST_WRAP_END=$'\n# END dotfiles\n'

# Functions

ask() {
	echo -n "$1 (y/n) "
	read
}

answer_is_yes() {
	[[ "$REPLY" =~ ^[Yy]$ ]]
}

file_create_if_not_exist() {
	if ! [ -f "$1" ]; then
		echo "Creating file '$1'"
		touch "$1"
	fi
}

file_remove_if_exist() {
	if [ -f "$1" ]; then
		echo "Removing file '$1'"
		rm -f "$1"
	fi
}

symlink_create() {
	file_remove_if_exist "$1"
	echo "Symlinking '$1' to '$2'"
	ln -s "$2" "$1"
}

get_content() {
	cat "$1"
}

get_source_command() {
	echo -e "if [ -f $1 ]; then\n\tsource $1\nfi"
}

get_absdir() {
	# Command for getting full path to script taken from https://stackoverflow.com/a/246128
	local dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
	echo "$dir"
}

get_reldir() {
	local dir="$1"
	if [ -z "$dir" ]; then
		dir=$(get_absdir)
	fi
	if [[ $dir == "$HOME"* ]]; then
		dir=$"\$HOME${dir#$HOME}"
	fi
	echo "$dir"
}

wrap() {
	echo "$CONST_WRAP_BEGIN$1$CONST_WRAP_END"
}

remove_wrap() {
	content="$(get_content "$1")"
	if [[ $content == *$CONST_WRAP_BEGIN*$CONST_WRAP_END* ]]; then
		echo "Removing old wrap from '$1'"
		content=${content//$CONST_WRAP_BEGIN*$CONST_WRAP_END}
	fi
	echo -e "$content" > tempfile && mv tempfile "$1"
}

prepend_text() {
	file_create_if_not_exist "$2"
	local str=$(wrap "$1")
	echo "Modifying file '$2'"
	echo -e "$str" | cat - "$2" > tempfile && mv tempfile "$2"
}

append_text() {
	file_create_if_not_exist "$2"
	local str=$(wrap "$1")
	echo "Modifying file '$2'"
	echo "$str" >> "$2"
}

prepend_content() {
	local content=$(get_content "$1")
	prepend_text "$content" "$2"
}

append_content() {
	local content=$(get_content "$1") 
	append_text "$content" "$2"
}

# Begin
ask "This script may modify existing dotfiles in the home folder. Continue?"
if ! answer_is_yes; then
	exit 1
fi

# Setup
ABSDIR=$(get_absdir)
RELDIR=$(get_reldir "$ABSDIR")

# Bash
remove_wrap "$HOME/.bash_profile"
prepend_text "$(get_source_command "$RELDIR/.bashrc")" "$HOME/.bash_profile"
remove_wrap "$HOME/.bashrc"
prepend_text "$(get_source_command "$RELDIR/.bashrc")" "$HOME/.bashrc"

# Vim
symlink_create "$HOME/.vimrc" "$ABSDIR/.vimrc"

# End
echo "All set! Open a new shell to activate all changes."
