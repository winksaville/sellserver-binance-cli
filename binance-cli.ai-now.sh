#!/usr/bin/env bash

# -----------------------------------------
# From https://stackoverflow.com/questions/821396/aborting-a-shell-script-if-any-command-returns-a-non-zero-value
# Terminate script on any errors or references to unset variable or a pipe failure
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

# We assume the directory that this file resides in contians all the resources
# needed, except that the binance-cli program is available on the default $PATH.
cd $PROG_DIR

# Configuration MUST exist
config=configs/current-config.toml
if [ ! -f "$config" ]; then
  echo "$config does not exit"
  exit 1
fi

# Data directory must exist
data_dir=data
if [ ! -d $data_dir ]; then
  echo "$data_dir does not exit"
  exit 1
fi

# Initialize variables
app="binance-cli -c $config"
now=$(date -Iseconds)
ai_logfile=$data_dir/ai-$now.txt

# Output the account info before sell-buy-withdraw
$app ai --no-verbose > $ai_logfile 2>&1

# Email the ai_logfile
if [ "$test_mode" == "--test" ]; then
  # Just email wink@saville.com if testing
  s-nail -a $ai_logfile -s "ai $ai_logfile" wink@saville.com <<< "ai $now"
else
  s-nail -a $ai_logfile -s "ai $ai_logfile" ksaville@gmail.com wink@saville.com <<< "ai $now"
fi
