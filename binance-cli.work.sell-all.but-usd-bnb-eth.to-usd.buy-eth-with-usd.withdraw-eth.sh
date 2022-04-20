#!/usr/bin/env bash

# -----------------------------------------
# From https://stackoverflow.com/questions/821396/aborting-a-shell-script-if-any-command-returns-a-non-zero-value
# Terminate script on any errors, references to unset variable or a pipe failure
set -e
set -u
#set -x
set -o pipefail
# -----------------------------------------

# Pass --no-test, --test or no parameters which means --test
if [ "$#" -ge 1 ]; then
  test_mode=$1
else
  test_mode=--test
fi

# script path, filename, directory
# from: https://stackoverflow.com/a/45392962/4812090
PROG_PATH=${BASH_SOURCE[0]}      # this script's name
PROG_NAME=${PROG_PATH##*/}       # basename of script (strip path)
PROG_DIR="$(cd "$(dirname "${PROG_PATH:-$PWD}")" 2>/dev/null 1>&2 && pwd)"

# Turn off verbose mode so captured output is cleaner
verbose=--no-verbose

# No confirmation prompts as this is a script
confirmation=--no-confirmation-required

# Configuration MUST exist
config=configs/current-config.toml
if [ ! -f "$config" ]; then
  echo "$config does not exit"
  exit 1
fi

# Application with initial set of parameters
app="binance-cli -c $config $verbose $confirmation $test_mode"

# Do the work
echo "$PROG_NAME Starting at date=$(date -Iseconds)"
#$app --help
$app auto-sell
$app auto-buy
$app withdraw ETH 100%
#$app withdraw ETH 100% --keep-min '$5'
echo "$PROG_NAME Completed at date=$(date -Iseconds)"
