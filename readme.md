# mkxh, enlarge your (m?)ksh

we want to share functions like the other langages does (writting, testing,
documenting, sharing and commenting libraries).

We have `$PATH`, we have `source` so we can write libraries instead of
rewritting functions repeatedly. This repo is an aim to start a discussion
about a convention to share functions writen in ksh.

Please feedback and discuss with us about about something like
[CPAN](http://metacpan.org/) for mksh.

Also interesting readings:

* [module](http://modules.sourceforge.net/c/module.html), module system for shells and tcl
* [zsh-uze](http://zsh-uze.github.io/) adresses the same problem using zsh and stealing from
  [perl](http://www.perl.org).

## todo

this is a WIP, document, experiment, test ...

## proposed helpers

should be in the documentation

    store_new () { tree_new $1 /dev/shm/store.XXXXX ; }
    alias be='leaf_set'

## Acknowledgments

mkxh started as a experiment to make [zsh-uze](http://zsh-uze.github.io/)
compatible with [mksh](https://www.mirbsd.org/mksh.htm). We came to the
conclusion it isn't a good idea to maintain a common library system
because it needs to renounce to very usefull [zsh](http://zsh.org/) features.

## technical opinions

25 years of shell made [me](http://eiro.github.io/) very opiniated about some things which are

* don't try to optimize performance, shell is all about simplicity and readability

* always use `set -u -e` (and it would be nice to steal `nowarncreateglobal` option from zsh)
  so you can have a poor man version of the [perl](http://www.perl.org)'s `use strict`.

* don't use aliases if you don't know what they are or if you don't need their properties,
  use functions instead.

## what aliases really are

you can see them as poor man preprocessing. they produce inplace replacement
that can be very usefull.

    alias error='return 254'
    hello () {
        test $USER ||
            error
    }
    typeset -f hello

outputs

    hello() {
        test $USER || return 254
    }

which can be very usefull in some rare cases. the problem is aliases are not
usable after an interpolation so

    alias hello='echo hello world'
    hello
    echo and then
    greetings=hello
    $greetings

will lead to

    hello world
    and then
    mksh: <stdin>[5]: hello: not found

which can be very scarry for newbies as they successfully used hello. So please
use functions instead.

    alias ll='ls -l'

should actually be written as

    ll () { ls -l "$@" }

You can consider `fn_partial` from [fn.ksh](https://github.com/eiro/mkxh/blob/master/lib/fn.ksh)
which will act nicely as long as you have no problem with the eval.

