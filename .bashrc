DEFAULT_EDITOR=vim

# Aliases -------------------

# preferred options
alias rm="rm -iv"        # always confirm deletion
alias mv="mv -iv"        # always confirm overwrite
alias cp="cp -iv"        # always confirm overwrite
alias mkdir="mkdir -pv"  # create parent directories if they don't exist
# short notation
alias c="clear"
alias e=$DEFAULT_EDITOR
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
