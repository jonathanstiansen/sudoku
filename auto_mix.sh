#!/bin/sh
#
# Setup: apt-get install inotify-tools
# brew install fswatch
# Usage: inotifytest-elixir-mix [ADDITIONAL_ARGUMENTS_FOR_MIX_TEST...]
#
# When *.exs files in or beneath lib/ or test/ are modified, this script runs
# their corresponding test/*test.exs files and prints any errors or failures.
# If no such corresponding files are found, then all available tests are run.
#
# Written in 2014 by Suraj N. Kurapati <https://github.com/sunaku>

# inotifywait -rqme close_write --format '%w%f' lib test | while read file; do
fswatch -rode -0 *
# | while read file; do
#   # map the changed file to its corresponding test file
#   case "$file" in
#     (lib/*.ex|lib/*.exs) test=test${file#lib}
#                          test=${test%.*}_test.exs
#                          [ -f "$test" ] || unset test ;; # file mapped to test
#     (test/*test.exs)     test=$file                   ;; # file is test itself
#     (test/*.exs)         unset test                   ;; # file is test itself
#     (*)                  continue                     ;; # skip unknown files
#   esac

#   # show which file changed and which test will be run
#   printf '\033[33m%s -> \033[36m%s\033[0m\n' \
#     "$( date -r "$file" +%X )" \
#     "$file$( [ -n "$test" -a "$test" != "$file" ] && echo " -> $test" )"

#   # run the test, which will print errors and failures
#   mix test ${test:+"$test"} "$@"
# done