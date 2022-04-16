#!/usr/local/env bash
#
# Author: Paulo Jeronimo <paulojeronim@gmail.com>

GC_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")"; pwd)

gc() {
  local gc_log=$GC_DIR/gc.log

  running() { echo running pid=$1; }
  stoped() { echo stoped; }

  gc_version() {
    ganache --version
  }

  gc_start() {
    local pid
    pid=`gc_pid` && running $pid || { \
      ganache --port 7545 &> $gc_log &
    }
  }

  gc_pid() {
    local result
    local cmd
    set -o pipefail
    case `uname` in
      Linux) cmd="pgrep -a node | grep ganache";;
      Darwin) cmd="ps -a | grep ganache | grep -v grep";;
    esac
    eval $cmd | awk '{print $1}'
    result=$?
    set +o pipefail
    return $result
  }

  gc_status() {
    local pid
    pid=`gc_pid` && running $pid || stoped
  }

  gc_stop() {
    local pid
    pid=`gc_pid` && kill -s SIGTERM $pid
    wait $pid 2> /dev/null
    stoped
  }

  gc_log() {
    local op=${1:-view}
    case "$op" in
      name) echo $gc_log;;
      view) less $gc_log;;
      tail) tail -f $gc_log;;
    esac
  }

  gc_seedphrase() {
    grep "Mnemonic: " $gc_log
  }

  local op=${1:-status}
  shift
  if type gc_$op &> /dev/null
  then
    gc_$op "$@"
  else
    echo "\"$op\" is not a valid option"
  fi
}

# vim: ts=2 sw=2 et
