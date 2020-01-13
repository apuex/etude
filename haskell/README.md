# haskell

## Compiling

### Statically linking executables

```
cabal configure --disable-executable-dynamic --ghc-option=-optl=-static --ghc-option=-optl=-pthread
```

## References

- [Building statically linked binaries in Haskell with Docker - Roman Kuznetsov](https://kuznero.com/post/haskell/building-statically-linked-binaries/)
