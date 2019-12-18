# hello-csv

## create static executable

```
cabal configure --disable-executable-dynamic --disable-shared --ghc-option=-optl=-static
cabal build
```
