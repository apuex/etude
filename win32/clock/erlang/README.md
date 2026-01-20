# clock

Wall clock and steady clock implemented for antique OTP versions running on antique Windows versions.

## compile

### Generating compile commands

Antique OTP does not support `*.erl`.
Generating commands in the linux environment, and save to `.bat` file.

```
$ find apps -type f -name "*.erl" | grep \/src\/ | sed -e "s/^apps\/\(\S\+\)\/src\/\(\S\+\)/erlc -o apps\/\1\/ebin\/ apps\/\1\/src\/\2/g" | sort
erlc -o apps/clock/ebin/ apps/clock/src/clock_app.erl
erlc -o apps/clock/ebin/ apps/clock/src/clock.erl
erlc -o apps/clock/ebin/ apps/clock/src/clock_sup.erl
$
```

### Compile

### Generating `.boot`, `.script`, and create `.tar.gz` 

```
systools:make_script("clock-win64-otp17", [{path, ["apps/*/ebin"]}]).
systools:make_tar("clock-win64-otp17", [{erts, code:root_dir()}, {path, ["apps/*/ebin"]}, {outdir, "dist"}]).
```

## Test run
```
erl -pa apps/clock/ebin -boot clock-win64-otp17 -config sys
```

