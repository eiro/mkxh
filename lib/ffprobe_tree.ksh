. tree.ksh

ffprobe_dump_for () {
    ffprobe -v error -show_format -show_streams -of flat=s=/ "${1?path of the medium}"
}

ffprobe_dump_as_tree_commands () {
    sed -r '
        s/=/ /
        s#^streams/##
        s/^/leaf_set /
    ' "$@"
}

ffprobe_dump_eval () { eval "$( ffprobe_dump_as_tree_commands )" ; }

ffprobe_dump_in () {
    ffprobe_dump_for "$2" | ( cd "$1"; ffprobe_dump_eval ; )
}

: <<\=cut

=head1 examples

=head2 in memory dump of all informations about a media

    store=/dev/shm/videos
    mkdir $store
    tree_new video $store/XXXXXXXX
    ffprobe_all_as_tree $video my_cool.mp4


=cut

