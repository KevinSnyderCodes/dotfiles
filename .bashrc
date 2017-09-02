DEFAULT_EDITOR=vim

# Aliases -------------------

# preferred options
alias rm="rm -iv"        # always confirm deletion
alias mv="mv -iv"        # always confirm overwrite
alias cp="cp -iv"        # always confirm overwrite
alias mkdir="mkdir -pv"  # create parent directories if they don't exist
# short notation
alias c="clear"
alias e="$DEFAULT_EDITOR"
alias g="alias_git"
alias l="ls -lash"
alias p="PWD"
alias v="less"
# git
alias_git() {
	local param=""
	case $1 in
	"a" ) param="add" ;;
	"b" ) param="branch" ;;
	"c" ) param="commit" ;;
	"d" ) param="diff" ;;
	"i" ) param="init" ;;
	"r" ) param="reset" ;;
	"s" ) param="status" ;;
	"up" ) param="push" ;;
	"dn" ) param="pull" ;;
	esac
	if [ -n "$param" ]; then
		shift 1
		git "$param" "$@"
	else
		git "$@"
	fi
}
# directory traversal
alias ..="cd .."
alias .1="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."
alias .6="cd ../../../../../.."
alias .7="cd ../../../../../../.."
alias .8="cd ../../../../../../../.."
alias .9="cd ../../../../../../../../.."

# Functions -----------------

# extract() function based on [work by @xvoland](https://github.com/xvoland/Extract)
extract() {
	if [ -z "$1" ]; then
		# display usage if no parameters passed
		echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
		echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [...]"
	else
		for n in $@
		do
			if [ -f "$n" ]; then
				case "${n%,}" in
				*.tar.bz2|*.tar.gz|*.tar.xz|*tbz2|*.tgz|*.txz|*.tar)
						tar xvf "$n"		;;
				*.lzma)	unlzma ./"$n"		;;
				*.bz2)	bunzip2 ./"$n"		;;
				*.rar)	unrar x -ad /"$n"	;;
				*.gz)	gunzip /"$n"		;;
				*.zip)	unzip ./"$n"		;;
				*.z)	uncompress ./"$n"	;;
				*.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
						7z x ./"$n"			;;
				*.xz)	unxz ./"$n"			;;
				*.exe)	cabextract ./"$n"	;;
				*)
						echo "'$n' - unknown archive method"
						return 1
						;;
				esac
			else
				echo "'$n' - file does not exist"
				return 1
			fi
		done
	fi
}

convert() {
	if [ $# != 2 ]; then
		echo "Usage: <path/file_src.ext> <path/file_dest.ext>"
	else
		if [ -f "$1" ]; then
			case "${1%,}" in
			*.bin|*.cue)
				case "${2%,}" in
				*.iso)
					local filename
					if [[ "$1" == *.bin ]]; then
						filename=${1%.bin}
					else
						filename=${1%.cue}
					fi
					bchunk "$filename".bin "$filename".cue $2
					;;
				esac
				;;
			esac
		else
			echo "'$1' - file does not exist"
		fi
	fi
}
