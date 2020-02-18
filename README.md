# SSL Checker

:lock:Check your site's SSL status.

Based on Sukka's repository [CheckSSL](https://github.com/SukkaW/CheckSSL) .

I fixed some bugs and simplified it.

[![Author](https://img.shields.io/badge/Author-Sukka-b68469?style=flat-square)](https://skk.moe)
[![Modified](https://img.shields.io/badge/Modified-HAIZAKURA-blue?style=flat-square)](https://nya.run)
[![License](https://img.shields.io/github/license/HAIZAKURA/SSL-Checker?style=flat-square)](./LICENSE)

## Demo

Wait for update.

## Usage

First clone this repo:

```bash
$ git clone https://github.com/HAIZAKURA/SSL-Checker.git
$ cd SSL-Checker
```

Then give script permission to execute:

```bash
$ chmod +x runcheck.sh
```

Run `runcheck.sh` with your domain, just like

```bash
# Example
$ ./runcheck.sh nya.run
```

You will get a `nya.run.json` file at `results` directories.

## Output

Here is an example of `nya.run.json`:

```json
{
	"domain": "nya.run",
	"subject": "CN=nya.run",
	"start": "Feb 15 00:00:00 2020 GMT",
	"expire": "Feb 15 12:00:00 2021 GMT",
	"issuer": "C=US; O=DigiCert Inc; OU=www.digicert.com; CN=Encryption Everywhere DV TLS CA - G1",
	"status": "Valid",
	"statuscolor": "success",
	"check": "2020-02-18 19:34:21 CST",
	"remain": "363"
}
```

- **domain** - The domain your check
- **subject** - Details of your SSL
- **start** - When your SSL issued
- **expire** - When your SSL expired
- **issuer** - Details of your CA's chain
- **status** - Could be `Valid`, `Invalid`, `Soon Expired`(if it is less than 10d before expired), `Expired`
- **statuscolor** - `success` for Valid, `warning` for Soon Expired and `error` for Expired or Invilid

> you can work with CSS framework (such as Bootstrap) using `class="text-${statuscolor}"`

- **remain** - How many days before your SSL expired

## Original Author

**CheckSSL** © [Sukka](https://github.com/SukkaW), Released under the [MIT](./LICENSE) License.

> [Personal Website](https://skk.moe) · [Blog](https://blog.skk.moe) · GitHub [@SukkaW](https://github.com/SukkaW) · Telegram Channel [@SukkaChannel](https://t.me/SukkaChannel)

## Modified By

**SSL-Checker** © [HAIZAKURA](https://nya.run), Released under the [MIT](./LICENSE) License.

> [Personal Website](https://nya.run) · GitHub [@HAIZAKURA](https://github.com/HAIZAKURA) · Twitter [@haizakura_0v0](https://twitter.com/haizakura_0v0) · Telegram [@haizakura](https://t.me/haizakura)