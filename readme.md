# mkxh, enlarge your (m?)ksh

mkxh is a collection of function we all written so many times and maybe
a good start to discuss about something like [CPAN](http://cpan.org/)
for mksh.

# Acknowledgments

mkxh started as a experiment to make [zsh-uze](http://zsh-uze.github.io/)
compatible with [mksh](https://www.mirbsd.org/mksh.htm). We came to the
conclusion it isn't a good idea to maintain a common library system
because it needs to renounce to very usefull [zsh](http://zsh.org/) features.

# functions vs aliases

this is the current state of my opinon

* aliases must be used as poor man preprocessing (...)
* aliases aren't interpolated

    "$@"

* use `fn_partial`
