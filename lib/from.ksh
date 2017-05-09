. error.ksh


from () {

    local _EXPORTER_FILE=$1
    local _EXPORTER_NS=${1%.+(k|z|)sh}

    . $1

    test ${2-} = import || return

    shift 2
    local _EXPORTER_RESOLVER=__exporter_$_EXPORTER_NS
    local _fn
    shush whence $_EXPORTER_RESOLVER || _EXPORTER_RESOLVER=:
    for it; do
        $_EXPORTER_RESOLVER $it
        for _fn in $it; do
            eval "$_fn () { $_EXPORTER_NS\_$_fn  \"\$@\"; }"
        done
    done
}


