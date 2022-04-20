# sellserver binance-cli

This contians scripts and configuration to run binance-cli periodically.

> **Note: In no case can the authors of this program be held responsible
> for any damanges or monetary losses.**

## Using cron

One way to periodically run jobs on linux is to use cron, do a
search for help with your operating system. [Here is a link](https://www.digitalocean.com/community/tutorials/how-to-use-cron-to-automate-tasks-ubuntu-1804)
to a article that might be helpful.

Here is a cron table that runs kman-cronjob.sh once a day at about midnight UTC:
```
$ crontab -l
PATH=/RunCloud/Packages/httpd-rc/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

0 0 * * * /home/wink/binance-cli/kman-cronjob.sh
```

## License

Licensed under either of

- Apache License, Version 2.0 ([LICENSE-APACHE](LICENSE-APACHE) or http://apache.org/licenses/LICENSE-2.0)
- MIT license ([LICENSE-MIT](LICENSE-MIT) or http://opensource.org/licenses/MIT)

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted
for inclusion in the work by you, as defined in the Apache-2.0 license, shall
be dual licensed as above, without any additional terms or conditions.
