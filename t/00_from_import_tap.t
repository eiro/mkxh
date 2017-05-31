PATH+=:lib
. from.ksh
. error.ksh

from tap.ksh import :all

tap_do
    true; ok "ok is working so the 'from' keyword probably is"
tap_done
