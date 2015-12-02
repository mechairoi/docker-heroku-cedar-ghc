FROM mojodna/heroku-cedar:2.0.0

ENV PATH $PATH:/.cabal/bin

# libgmp hack
RUN ln -s /usr/lib/libgmp.so.3 /usr/lib/libgmp.so

# ghc
RUN curl --silent http://www.haskell.org/ghc/dist/7.10.2/ghc-7.10.2-x86_64-unknown-linux.tar.bz2|tar xj \
  && cd ghc-7.10.2/ && ./configure && make install && cd .. \
  && rm -r ghc-7.10.2/ /usr/local/bin/haddock* /usr/local/lib/ghc-7.10.2/haddock /usr/local/lib/ghc-7.10.2/html /usr/local/lib/ghc-7.10.2/latex /usr/local/share/doc/ghc \
  && echo "" > /usr/local/lib/ghc-7.10.2/ghc-usage.txt \
  && echo "" > /usr/local/lib/ghc-7.10.2/ghci-usage.txt \
  && find /usr/local/lib -name "*_p.a" -delete \
  && find /usr/local/lib -name "*.p_hi" -delete \
  && find /usr/local/lib -name "*.dyn_hi" -delete \
  && find /usr/local/lib -name "*HS*.so" -delete \
  && find /usr/local/lib -name "*HS*.o" -delete \
  && find /usr/local/lib -name "*_debug.a" -delete \
  && strip --strip-unneeded /usr/local/lib/ghc-7.10.2/runghc /usr/local/lib/ghc-7.10.2/ghc

# cabal-install & cabal update & happy
RUN curl --silent http://hackage.haskell.org/package/cabal-install-1.22.4.0/cabal-install-1.22.4.0.tar.gz|tar xz \
  && cd cabal-install-1.22.4.0/ && sh bootstrap.sh && cd .. &&  rm -r cabal-install-1.22.4.0/ \
  && wget https://www.stackage.org/lts/cabal.config \
  && /.cabal/bin/cabal update \
  && /.cabal/bin/cabal install happy \
  && /.cabal/bin/cabal install stack
