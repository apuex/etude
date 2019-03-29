FROM haskell:latest

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y apt-utils build-essential haskell-platform libgtksourceview-3.0-dev libwebkitgtk-3.0-dev
RUN cabal update
RUN cabal install Cabal cabal-install
RUN cabal install regex-tdfa-text --ghc-options=-XFlexibleContexts
RUN cabal install alex happy
RUN cabal install gtk2hs-buildtools

CMD ["/bin/bash"]

