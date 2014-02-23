FROM mojodna/heroku-cedar:2.0.0
RUN curl --silent http://www.haskell.org/ghc/dist/7.6.3/ghc-7.6.3-x86_64-unknown-linux.tar.bz2|tar xj
# ADD README.md /README.md
RUN curl https://raw.github.com/mechairoi/heroku-buildpack-haskell/master/precompile-binaries.sh | bash
