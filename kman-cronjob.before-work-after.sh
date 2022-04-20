#!/usr/bin/env bash

# -----------------------------------------
# From https://stackoverflow.com/questions/821396/aborting-a-shell-script-if-any-command-returns-a-non-zero-value
# Terminate script on any errors or references to unset variable or a pipe failure
set -e
set -u
#set -x
set -o pipefail
# -----------------------------------------

cd /home/wink/binance-cli

# Get the date_time
now=$(date -Iseconds)

# Define the log file
logfile=data/kman-cronjob_date_$now.log

# Configuration MUST match ./kman-work.sell-all.but-usd-bnb-eth.to-usd.buy-eth-with-usd.withdraw-eth.sh
config=configs/kman-config.sell-all.but-usd-bnb-eth.to-usd.buy-eth-with-usd.toml

# Application with initaial set of parameters
app="/home/wink/bin/binance-cli -c $config"

# Output the account info before sell-buy-withdraw
ai_logfile=data/ai-$(date -Iseconds).txt
$app ai --no-verbose > $ai_logfile 2>&1
s-nail -a $ai_logfile -s "ai before: $ai_logfile" wink@saville.com <<< "ai before"

# Execute work script capturing the output to the log
kman-work.sell-all.but-usd-bnb-eth.to-usd.buy-eth-with-usd.withdraw-eth.sh --no-test >> $logfile  2>&1

# Output the account info after sell-buy-withdraw
ai_logfile=data/ai-$(date -Iseconds).txt
$app ai --no-verbose > $ai_logfile 2>&1
s-nail -a $ai_logfile -s "ai after: $ai_logfile" wink@saville.com <<< "ai after"

# Email the log file
s-nail -a $logfile -s "SellServer report: $logfile" ksaville@gmail.com wink@saville.com <<< "SellService report for $now"

