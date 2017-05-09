: <<\=cut

=head1 tree functions

definitions

    * a leaf is a file, possibly in a directory
    * a tree is a directory and all its content, recursively

=head1 ffprobe_all_*

=cut

leaf_ready () {
    # exists as a regular file ? then job's done
    test -f "$1" && return

    # exists as a directory ? then it can't be a leaf
    test -d "$1" && { false; return; }

    # if there is a '/' in the name, there is a dirname
    # so we have to make sure it exists

    # if there is no '/' in the path, the leaf is a
    # file in the current directory. there is nothing
    # more to do.

    # else, ensure the dirname exists
    test "${1%%*/*}" || mkdir -p -- "${1%/*}"

}

leaf_echo () {
    # echo the name of the leaf when it is ready
    leaf_ready "$1" && echo "$1"
}

leaf_set () {
    # echo a value in a leaf
    leaf_ready "$1"
    echo "$2" > "$1"
}

tree_new () { eval "$1=$( mktemp -d "$2" )" ; }
