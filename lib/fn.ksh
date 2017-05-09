fn_partial () {
    local it=$1
    shift
    eval "$it () { $* \"\$@\"; }"
}

fn_also () {
    fn_partial $1 ${2?$0 alias name alias name alias name ...}
    (( $# > 2 )) || return
    shift 2
    fn_also "$@"
}

fn_import_from () {
    local it prefix=$1
    shift
    for it; do fn_partial $it $prefix$it; done
}
