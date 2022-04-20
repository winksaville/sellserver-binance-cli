#!/usr/bin/env bash

# -----------------------------------------
# From https://stackoverflow.com/questions/821396/aborting-a-shell-script-if-any-command-returns-a-non-zero-value
# Terminate script on any errors or references to unset variable or a pipe failure
set -e
set -u
set -x
set -o pipefail
# -----------------------------------------

cd /home/wink/binance-cli

# Initialize variables
config=configs/kman-config-sell-all-but-usd-bnb-buy-eth.toml
app="/home/wink/bin/binance-cli -c $config"
now=$(date -Iseconds)
ai_logfile=data/ai-$now.txt

# Output the account info before sell-buy-withdraw
$app ai --no-verbose > $ai_logfile 2>&1
s-nail -a $ai_logfile -s "ai $ai_logfile" ksaville@gmail.com wink@saville.com <<< "ai $now"

