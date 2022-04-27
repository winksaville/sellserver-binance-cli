# sellserver binance-cli

This contians scripts and configuration to run binance-cli periodically and
is **DANGEROUS** in that it can SELL, BUY and WITHDRAW crypto assets all by itself.
You **ABSOLUTELY MUST** be very careful.

> **Note: In no case can the authors of this program be held responsible
> for any damanges or monetary losses.**

## Setup

Clone this repo typically into `binance-cli/`:
```
git clone https://github.com/winksaville/sellserver-binance-cli binance-cli
```

Then setup a cronjob to periodically run, [here is a link](https://www.digitalocean.com/community/tutorials/how-to-use-cron-to-automate-tasks-ubuntu-1804)
to an article that might be helpful.

Currently the crontab is setup to run `binance-cli.cronjob.sh` **once a week**
on [Monday at midnight UTC](https://crontab.guru/#0_0_*_*_1).
```
$ crontab -l
PATH=/home/wink/bin:/RunCloud/Packages/httpd-rc/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

0 0 * * 1 /home/wink/binance-cli/binance-cli.cronjob.sh --no-test
```

Prviously it was setup to run `binance-cli.cronjob.sh` once a day at midnight UTC:
```
$ crontab -l
PATH=/home/wink/bin:/RunCloud/Packages/httpd-rc/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

0 0 * * * /home/wink/binance-cli/binance-cli.cronjob.sh --no-test
```

Next you need to setup `configs/current-config.toml`. Currently `configs/current-config.toml` 
is a symbolic link to `configs/example-config.toml`. I suggest creating something like
`configs/my-config.toml`, with the appropriate configuraiton, and then do:
```
ln -s configs/current-config.toml configs/my-config.toml
```
Doing so you won't have to change any of the scripts.

## Running

By default the shell scripts will run in "--test" mode if there is no parameter, pass
"--no-test" as shown in the crontab to run it in for "real".

To test run `./binance-cli.cronjob.sh` or `./binance-cli.cronjob.sh --test`, which you
should **ABSOLUTELY** do before you do a `--no-test` run. Be sure you look at the logs
and the email to verify it is doing what you intended.

## Syncing

Periodically it will be deseriable to sellserver:/binance-cli with copies
on other machines, such as 3900x. Since this git repo exists any items in the
repo should be sync by cloning the repo and keeping each machine sync'd with
the repo. But for information not checked into the repo will have to be manually synced.
Examples are the `data` and `configs` directories.


One way to do that is to use `rsync`. I did a search and
[this stackoverflow](https://stackoverflow.com/a/1602348/4812090) provided some good
information.

Based on the above here is a methodlogy, for `data/` and `configs/` start with below,
which will show the list of files that will be copied from `sellserver:~/binance-cli/data`
to `3900x:~/prgs/sellserver-binance-cli/data`:
```
wink@3900x 22-04-27T17:40:49.897Z:~/prgs/sellserver-binance-cli (main)
$ rsync --dry-run -rtuacv sellserver:~/binance-cli/data/ ./data
receiving incremental file list
./
ai-after-2022-04-20T23:36:39+00:00.txt
ai-after-2022-04-20T23:50:15+00:00.txt
ai-after-2022-04-21T00:14:56+00:00.txt
ai-after-2022-04-22T00:02:12+00:00.txt
ai-after-2022-04-23T00:01:15+00:00.txt
ai-after-2022-04-24T00:01:09+00:00.txt
ai-after-2022-04-25T00:01:14+00:00.txt
ai-after-2022-04-26T00:01:10+00:00.txt
ai-after-2022-04-27T00:01:17+00:00.txt
ai-before-2022-04-20T23:33:21+00:00.txt
ai-before-2022-04-20T23:46:52+00:00.txt
ai-before-2022-04-21T00:00:01+00:00.txt
ai-before-2022-04-21T00:10:01+00:00.txt
ai-before-2022-04-22T00:00:01+00:00.txt
ai-before-2022-04-23T00:00:01+00:00.txt
ai-before-2022-04-24T00:00:01+00:00.txt
ai-before-2022-04-25T00:00:01+00:00.txt
ai-before-2022-04-26T00:00:01+00:00.txt
ai-before-2022-04-27T00:00:01+00:00.txt
binance-cli.cronjob_date_2022-04-20T23:33:21+00:00.log
binance-cli.cronjob_date_2022-04-20T23:46:52+00:00.log
binance-cli.cronjob_date_2022-04-21T00:10:01+00:00.log
binance-cli.cronjob_date_2022-04-22T00:00:01+00:00.log
binance-cli.cronjob_date_2022-04-23T00:00:01+00:00.log
binance-cli.cronjob_date_2022-04-24T00:00:01+00:00.log
binance-cli.cronjob_date_2022-04-25T00:00:01+00:00.log
binance-cli.cronjob_date_2022-04-26T00:00:01+00:00.log
binance-cli.cronjob_date_2022-04-27T00:00:01+00:00.log
kman-order-log.txt

sent 759 bytes  received 16,313 bytes  11,381.33 bytes/sec
total size is 3,911,627  speedup is 229.13 (DRY RUN)
wink@3900x 22-04-27T17:41:07.690Z:~/prgs/sellserver-binance-cli (main)
```

For a more detailed list add `--itemize-changes` and look at the the `man rsync`
for information to decode the list :)
```
wink@3900x 22-04-27T16:43:36.153Z:~/prgs/sellserver-binance-cli (main)
$ rsync --dry-run --itemize-changes -rtuacv sellserver:~/binance-cli/data/ ./data
receiving incremental file list
.d..t...... ./
.f..tp..... .gitignore
.f..t...... ai-2022-01-02T00:45:02+00:00.txt
.f..t...... ai-2022-01-02T00:47:00+00:00.txt
.f..t...... ai-2022-01-02T00:47:23+00:00.txt
.f..t...... ai-2022-01-02T00:49:42+00:00.txt
.f..t...... ai-2022-01-02T00:50:07+00:00.txt

...

.f..t...... kman-cronjob_date_2022-01-10T00:00:01+00:00.log
.f..t...... kman-cronjob_date_2022-01-11T00:00:01+00:00.log
.f..t...... kman-cronjob_date_2022-01-12T00:00:01+00:00.log
.f..t...... kman-cronjob_date_2022-01-13T00:00:01+00:00.log
>fcst...... kman-order-log.txt
.f..t...... kman-sell-all-but-usd-bnb-buy-eth-withdraw-eth-output_2021-11-13T23:03:06+00-00.txt
.f..t...... sose.log

sent 759 bytes  received 16,313 bytes  11,381.33 bytes/sec
total size is 3,911,627  speedup is 229.13 (DRY RUN)
```

The remove the `--dry-run` parameter and do the actual sync:
```
wink@3900x 22-04-27T17:41:07.690Z:~/prgs/sellserver-binance-cli (main)
$ rsync -rtuacv sellserver:~/binance-cli/data/ ./data
receiving incremental file list
./
ai-after-2022-04-20T23:36:39+00:00.txt
ai-after-2022-04-20T23:50:15+00:00.txt
ai-after-2022-04-21T00:14:56+00:00.txt
ai-after-2022-04-22T00:02:12+00:00.txt
ai-after-2022-04-23T00:01:15+00:00.txt
ai-after-2022-04-24T00:01:09+00:00.txt
ai-after-2022-04-25T00:01:14+00:00.txt
ai-after-2022-04-26T00:01:10+00:00.txt
ai-after-2022-04-27T00:01:17+00:00.txt
ai-before-2022-04-20T23:33:21+00:00.txt
ai-before-2022-04-20T23:46:52+00:00.txt
ai-before-2022-04-21T00:00:01+00:00.txt
ai-before-2022-04-21T00:10:01+00:00.txt
ai-before-2022-04-22T00:00:01+00:00.txt
ai-before-2022-04-23T00:00:01+00:00.txt
ai-before-2022-04-24T00:00:01+00:00.txt
ai-before-2022-04-25T00:00:01+00:00.txt
ai-before-2022-04-26T00:00:01+00:00.txt
ai-before-2022-04-27T00:00:01+00:00.txt
binance-cli.cronjob_date_2022-04-20T23:33:21+00:00.log
binance-cli.cronjob_date_2022-04-20T23:46:52+00:00.log
binance-cli.cronjob_date_2022-04-21T00:10:01+00:00.log
binance-cli.cronjob_date_2022-04-22T00:00:01+00:00.log
binance-cli.cronjob_date_2022-04-23T00:00:01+00:00.log
binance-cli.cronjob_date_2022-04-24T00:00:01+00:00.log
binance-cli.cronjob_date_2022-04-25T00:00:01+00:00.log
binance-cli.cronjob_date_2022-04-26T00:00:01+00:00.log
binance-cli.cronjob_date_2022-04-27T00:00:01+00:00.log
kman-order-log.txt

sent 8,345 bytes  received 602,986 bytes  407,554.00 bytes/sec
total size is 3,911,627  speedup is 6.40
```

If you then run a second time, you'll see that no files are updated:
```
wink@3900x 22-04-27T17:45:27.035Z:~/prgs/sellserver-binance-cli (main)
$ rsync --dry-run -rtuacv sellserver:~/binance-cli/data/ ./data
receiving incremental file list

sent 20 bytes  received 15,578 bytes  10,398.67 bytes/sec
total size is 3,911,627  speedup is 250.78 (DRY RUN)
```

After `data/` do a `--dry-run` on `configs/`, you should on see the
`current-config.toml` sym link being different, which is normal and
that should **NOT** be sync'd.
```
wink@3900x 22-04-27T17:46:28.375Z:~/prgs/sellserver-binance-cli (main)
$ rsync --dry-run -rtuacv sellserver:~/binance-cli/configs/ ./configs
receiving incremental file list
./
current-config.toml -> kman-config.sell-all.but-usd-bnb-eth.to-usd.buy-eth-with-usd.toml

sent 42 bytes  received 416 bytes  305.33 bytes/sec
total size is 15,738  speedup is 34.36 (DRY RUN)
```


Another option is to use [Unison](https://github.com/bcpierce00/unison).
It's available on [Arch](https://wiki.archlinux.org/title/unison) and
[Ubuntu](https://www.unixmen.com/synchronize-files-with-unison-on-ubuntu) and
[Mac OS X via homebrew](https://formulae.brew.sh/formula/unison). And Unison
looks very good and the latest version, v2.52, looks much improved regarding forward and
backwards compatibility, which for earlier versions was a problem, see:
[2.52 Migraiton Guide](https://github.com/bcpierce00/unison/wiki/2.52-Migration-Guide).
Of course Unison on [Arch Linux](https://wiki.archlinux.org/title/unison) and
[homebrew](https://formulae.brew.sh/formula/unison) have v2.52, but on ubuntu 20.04 it's v2.48:
```
$ apt-cache policy unison
unison:
  Installed: (none)
  Candidate: 2.48.4-4ubuntu1
  Version table:
     2.48.4-4ubuntu1 500
        500 http://mirrors.digitalocean.com/ubuntu focal/universe amd64 Packages
```
So I'll need to build a 2.52 version for ubuntu, but for right now using rsync
looks eaiser.


## License

Licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or http://apache.org/licenses/LICENSE-2.0)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall
be dual licensed as above, without any additional terms or conditions.
