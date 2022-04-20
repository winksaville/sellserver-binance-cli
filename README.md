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
to a article that might be helpful.

Here is a cron table that runs binance-cli.cronjob.sh once a day at midnight UTC:
```
$ crontab -l
PATH=/RunCloud/Packages/httpd-rc/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

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

## License

Licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or http://apache.org/licenses/LICENSE-2.0)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall
be dual licensed as above, without any additional terms or conditions.
