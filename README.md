# AdMob-SSV

Google Admob server-side verification system for Common Lisp

## Installation

This system can be installed from [UltraLisp](https://ultralisp.org/) like this:

```common-lisp
(ql-dist:install-dist "http://dist.ultralisp.org/"
                      :prompt nil)
(ql:quickload "admob-ssv")
```

## Usage

```common-lisp
(admob-ssv:verify *ssv-callback-url*)
```

SSV callback url example:

```
https://www.yourdomain.com/ssv-callback?ad_network=5450213213286189855&ad_unit=12345678&reward_amount=10&reward_item=coins&timestamp=1507770365237823&transaction_id=1234567890ABCDEF12&user_id=1234567&signature=MEUCIQDGx44BZgQU6TU4iYEo1nyzh3NgDEvqNAUXlax-XPBQ5AIgCXSdjgKZvs_6QNYad29NJRqwGIhGb7GfuI914MDDZ1c&key_id=1268422387

```


## Documentation

- [Google Docs: Validate server-side verification (SSV) callbacks](https://developers.google.com/admob/android/rewarded-video-ssv)
