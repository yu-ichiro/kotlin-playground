#!/usr/bin/env bash
# envrn.sh - The ultimate bash task runner

# define any project related variables that should be declared in envrn.sh.
# (Note: the local .env file will be read to, but this will override it)

export PROJECT_NAME="kotlin-playground"
export VERSION="0.1.0"

# define each task as bash functions

compile() {
  (
    cd $__PWD__
    kotlinc -d 'main.jar' -include-runtime "$@"
  )
}

run() {
  (
    cd $__PWD__
    java -jar main.jar
  )
}

shell() {
    PATH="$PATH:$__DIR__" exec $SHELL
}

# add descriptions to each task

help() {
    cat << EOF
Usage: envrn.sh TASK|COMMAND [OPTIONS]

TASK:
    compile: compiles a given *.kt file to a single jar (main.jar)
    run: runs main.jar
    shell: enters a new shell with .env read into, and __DIR__ added to \$PATH
    help: show this message
COMMAND:
    any command that will be run with .env read into
EOF
}

# --------------- envrn.sh -----------------
# (C) 2021 Yuichiro Smith <contact@yu-smith.com>
# This script is distributed under the Apache 2.0 License
# See the full license at https://github.com/yu-ichiro/envrn.sh/blob/main/LICENSE

__PWD__=$PWD
__DIR__="$(
  src="${BASH_SOURCE[0]}"
  while [ -h "$src" ]; do
    dir="$(cd -P "$(dirname "$src")" && pwd)"
    src="$(readlink "$src")"
    [[ $src != /* ]] && src="$dir/$src"
  done
  printf %s "$(cd -P "$(dirname "$src")" && pwd)"
)"

cd -P $__DIR__

if [ -e '.env' ];then
    set -a; eval "$(cat .env <(echo) <(declare -x))"; set +a;
fi

task=${1:-help}
shift
$task "$@"
