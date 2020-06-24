# MFC Serialize Tests


## Serializing `CLocation(456, 123)` with `Serialize(archive)`
```
$ hexdump -C 123.bin
00000000  c8 01 7b 00                                       |..{.|
00000004
```

## Serializing `CLocation(-456, -123)` with `Serialize(archive)`
```
$ hexdump -C 123.bin
00000000  38 fe 85 ff                                       |8...|
00000004
```

## Serializing `CLocation(-456, -123)` with `archive << &point;`
```
$ hexdump -C 123.bin
00000000  ff ff fe ca 09 00 43 4c  6f 63 61 74 69 6f 6e 38  |......CLocation8|
00000010  fe 85 ff                                          |...|
00000013
```

## Serializing `CPerson("Wangxy", 123)` with `Serialize(archive)`

```
$ hexdump -C 123.bin
00000000  06 57 61 6e 67 78 79 7b  00                       |.Wangxy{.|
00000009
```
