#!/usr/bin/env bash

# -----------------------------------------
# From https://stackoverflow.com/questions/821396/aborting-a-shell-script-if-any-command-returns-a-non-zero-value
# Terminate script on any errors, references to unset variable or a pipe failure
set -e
set -u
set -o pipefail
# -----------------------------------------

# Pass --no-test, --test or no parameters which means --test
if [ "$#" -ge 1 ]; then
  test_mode=$1
else
  test_mode=--test
fi

# Turn off verbose mode so captured output is cleaner
verbose=--no-verbose

# Name of the script for progress info
script_name=$(basename $0)

# No confirmation prompts as this is a script
confirmation=--no-confirmation-required

# Configuration MUST match ./kman-cronjob.before-sell-after.sh
config=configs/kman-config.sell-all.but-usd-bnb-eth.to-usd.buy-eth-with-usd.toml

# Application with initaial set of parameters
app="/home/wink/bin/binance-cli -c $config $verbose $confirmation $test_mode"

# Do the work
echo "$script_name Starting at date=$(date -Iseconds)"
$app auto-sell
$app auto-buy
$app withdraw ETH 100% 0xd989942D49De163A54273af6De971Ba80308D5cD
#$app withdraw ETH 100% --keep-min '$5' 0xd989942D49De163A54273af6De971Ba80308D5cD
echo "$script_name Completed at date=$(date -Iseconds)"
