alias if_zsh='test ${ZSH_VERSION-} &&'

if_zsh {
    (( $+LAST_ERROR )) ||
    typeset -g LAST_ERROR
}

LAST_ERROR=${LAST_ERROR-}
warn     () { LAST_ERROR=$?; echo "$*" >&2; return $LAST_ERROR ; }
die      () { LAST_ERROR=$?; echo "$*" >&2; exit   $LAST_ERROR ; }
shush    () { "$@" &> /dev/null ; }
shush1   () { "$@" 1> /dev/null ; }
shush2   () { "$@" 2> /dev/null ; }

alias error='warn "in $0 line ${LINENO-unknown}:"'
alias ...='{error Unimplemented; return 255 ;}'
