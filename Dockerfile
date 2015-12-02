FROM heroku/cedar

ENV PATH $PATH:/.cabal/bin

RUN apt-get update && apt-get -y install libgmp-dev --no-install-recommends

# ghc
RUN curl --silent http://downloads.haskell.org/~ghc/7.10.2/ghc-7.10.2-x86_64-unknown-linux-deb7.tar.bz2|tar xj \
  && cd ghc-7.10.2/ && ./configure && make install

# cabal-install & cabal update & happy
RUN curl --silent http://hackage.haskell.org/package/cabal-install-1.22.4.0/cabal-install-1.22.4.0.tar.gz |tar xz \
  && cd cabal-install-1.22.4.0/ && sh bootstrap.sh && cd .. &&  rm -r cabal-install-1.22.4.0/ \
  && wget https://www.stackage.org/lts/cabal.config \
  && /root/.cabal/bin/cabal update \
  && /root/.cabal/bin/cabal install happy \
  && /root/.cabal/bin/cabal install stack
