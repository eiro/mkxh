LAST_ERROR=${LAST_ERROR:-}
warn     () { LAST_ERROR=$?; echo "$*" >&2; return $LAST_ERROR ; }
die      () { LAST_ERROR=$?; echo "$*" >&2; exit   $LAST_ERROR ; }
shush    () { "$@" &> /dev/null ; }
shush1   () { "$@" 1> /dev/null ; }
shush2   () { "$@" 2> /dev/null ; }
alias error='warn "in $0 line ${LINENO:-unknown}:"'

# TODO:
# doesn't work with mksh < R56
# alias ...='{error Unimplemented; return 255 ;}'

set_mksh_version () {
    MKSH_VERSION="${KSH_VERSION?the running shell is not korn}"
    test "${MKSH_VERSION#*MIRBSD KSH*}" || {
        warn "running shell isn't mksh"
        return 1
    }

    MKSH_VERSION="${MKSH_VERSION#*MIRBSD KSH R}"
    export MKSH_VERSION="${MKSH_VERSION% *}"
}

test ${ZSH_VERSION:-} || set_mksh_version
