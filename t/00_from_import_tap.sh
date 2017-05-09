PATH+=:lib
. from.ksh

from tap.ksh import :all

tap_do
    true; ok "true"
tap_done
