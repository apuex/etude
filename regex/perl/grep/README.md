# linux grep perl regex

## examples

### grep file names with given pattern

1. grep files with given extensions.


```
$ find . -type f | grep -P '.*\.(java|scala|properties)$'
```

2. grep files names wit combinations of any number of numbers, upper and lower case letters, `-`'s, `_`'s, and extension `.md`.

```
$ find . -type f | grep -P "([0-9a-zA-Z\-\_]*)\.(md)$"
```

3. find some compressed files.

```
$ find $(pwd) -type f | grep -P "([\s0-9a-zA-Z\-\_\.]*)\.(gz|bz2|bz|zip|rar|7z)$"
```

4. find some music files.

```
find $(pwd) -type f | grep -P "([\s0-9a-zA-Z\-\_\.]*)\.(mp3|flac|wav|wma|m4a)$"
```

5. output only matched part.

```
$ find $(pwd) -type f | grep -o -P "([\s0-9a-zA-Z\-\_\.]*)\.(gz|bz2|bz|zip|rar|7z)$"
```

6. grep file name with email pattern.

```
$ find gs-messaging-jms -type f | grep -o -P '[A-Za-z0-9\-\_\$]*\o{100}[A-Za-z0-9\-\_\$\.]*\.([a-z]{3})$'
gates@mail.microsoft.com
bill-gates@microsoft.com
```

