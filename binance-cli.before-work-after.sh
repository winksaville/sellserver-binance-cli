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

# Get the date_time
now=$(date -Iseconds)

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

# Define the log file
logfile=$data_dir/binance-cli.cronjob_date_$now.log

# Application with initial set of parameters
app="binance-cli -c $config"

# Output the account info before sell-buy-withdraw
ai_logfile=$data_dir/ai-before-$(date -Iseconds).txt
$app ai --no-verbose > $ai_logfile 2>&1
s-nail -a $ai_logfile -s "ai before: $ai_logfile" wink@saville.com <<< "ai before"

# Execute work script capturing the output to the log
./binance-cli.work.sell-all.but-usd-bnb-eth.to-usd.buy-eth-with-usd.withdraw-eth.sh $test_mode > $logfile  2>&1

# Output the account info after sell-buy-withdraw
ai_logfile=$data_dir/ai-after-$(date -Iseconds).txt
$app ai --no-verbose > $ai_logfile 2>&1
s-nail -a $ai_logfile -s "ai after: $ai_logfile" wink@saville.com <<< "ai after"

# Email the log file

# Email the ai_logfile
if [ "$test_mode" == "--test" ]; then
  # Just email wink@saville.com if testing
  s-nail -a $logfile -s "SellServer report: $logfile" wink@saville.com <<< "SellService report for $now"
else
  s-nail -a $logfile -s "SellServer report: $logfile" ksaville@gmail.com wink@saville.com <<< "SellService report for $now"
fi
