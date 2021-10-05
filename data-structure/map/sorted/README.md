#sorted map

## compiling with Windows 2003 Server SDK

1. add `/MD` option to avoid link error unresolved symbols.

2. disable runtime stack check by specifing `/GS-` to avoid link error when using `/ENTRY:main` option.

```
cl /GS- /MD /EHsc sorted_map.cpp
```
