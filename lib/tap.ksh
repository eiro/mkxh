: <<\=cut

=head1 TAP producer for POSIX compliant shells

TAP is for L<Test Anything Protocol|https://testanything.org/>,
a simple text-based interface between testing modules in a test harness.

This library implements a
L<POSIX.2013|http://pubs.opengroup.org/onlinepubs/9699919799/> compliant
tested with different lightweight shells (dash, mksh, busybox sh) and
toolchains (9base, busybox applets, ...).

The present documentation is written using
L<POD|http://perldoc.perl.org/perlpod.html> format. you can use the perlodoc
command to render it in many different formats.

=head1 Functions

comming soon ... yet most of the functions names are stolen from the
L<Test::More|https://metacpan.org/pod/Test::More> library.

=head1 a basic example

    alias @='for it in'
    @ ok pretend note; do alias $it=tap_$it
    done

    basics_of_math () {
        tap_plan 2
        true   ;  ok "truth, straight"
        false  ;  ok "you shall not pass"
        note "because false doesn't pass"
        note "but i can count to 5"
        seq 5| tap_cat
        test 1 -eq 1; ok "one is one"
        test 1 -eq 2; ok "one is not two"
    }

    pretend basics_of_math

=cut

# echo $@ WWW
# for it in "$@"; do
#     echo $it will be aliased
#     case $it in
#         :all) it="ok plan done note" ;;
#     esac
#     eval "$it () { tap_$it \"\$@\" }"
# done

# . error.sh

# if_zsh { typeset -g _tap_msg_index=0 got= expected= }
_export_tap ()

tap_y    () { tap_msg ok "$*" ; }
tap_n    () { tap_msg 'not ok' "$*"; }
tap_note () { echo "# $*"   ; }
tap_cat  () { sed 's/^/# /' ; }
tap_msg  () {
    _tap_msg_index=$(( $_tap_msg_index + 1 ))
    echo "$1 $_tap_msg_index $2"
}

tap_ok () {
    local r=$?
    if test $r -eq 0
        then  tap_y "$*"
        else  tap_n "$*"
    fi
    return $r
}

tap_so () { test "$got" = "$expected"; tap_ok "$*"; }

tap_y    () { tap_msg ok "$*" ; }
tap_n    () { tap_msg 'not ok' "$*"; }

alias tap_reset='_tap_msg_index=0 got= expected='

tap_plan  () { echo 1..${1?number of expected tests} ; }
tap_do () {
    tap_reset
    test ${1-} && tap_plan $1
}

tap_done  () { tap_plan $_tap_msg_index ; }

__exporter_tap () {
    case $it in
        :all) it="ok plan note" ;;
    esac
}




