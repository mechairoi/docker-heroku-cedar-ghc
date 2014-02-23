#!/bin/sh

# libgmp hack
# mkdir -p $HOME/usr/lib
# ln -s /usr/lib/libgmp.so.3 $HOME/usr/lib/libgmp.so

# ghc
# curl --silent http://www.haskell.org/ghc/dist/7.6.3/ghc-7.6.3-x86_64-unknown-linux.tar.bz2|tar xj
cd ghc-7.6.3/
./configure # --prefix=$HOME/ghc --with-gmp-libraries=$HOME/usr/lib
make install
cd ..

# GHC space trimming (risky business)

# Remove haddock and hpc - no docs or coverage
rm /usr/local/bin/haddock*
rm /usr/local/lib/ghc-7.6.3/haddock
rm -r /usr/local/lib/ghc-7.6.3/html
rm -r /usr/local/lib/ghc-7.6.3/latex
# rm $HOME/ghc/bin/hp*
# rm -r $HOME/ghc/lib/ghc-7.4.1/hp*
# rm -r $HOME/ghc/lib/ghc-7.4.1/package.conf.d/hpc-0.5.1.1-*
# rm -r $HOME/ghc/lib/ghc-7.4.1/ghc-7.4.1
# rm -r $HOME/ghc/lib/ghc-7.4.1/package.conf.d/ghc-7.4.1-*
# rm -r $HOME/ghc/lib/ghc-7.4.1/package.conf.d/package.cache
echo "" > /usr/local/lib/ghc-7.6.3/ghc-usage.txt
echo "" > /usr/local/lib/ghc-7.6.3/ghci-usage.txt

# Remove duplicate libs
find /usr/local/lib -name "*_p.a" -delete
find /usr/local/lib -name "*.p_hi" -delete
find /usr/local/lib -name "*.dyn_hi" -delete
find /usr/local/lib -name "*HS*.so" -delete
find /usr/local/lib -name "*HS*.o" -delete
find /usr/local/lib -name "*_debug.a" -delete

# Don't need man or doc
rm -rf $HOME/ghc/share

# Strip binaries
strip --strip-unneeded $HOME/ghc/lib/ghc-7.6.3/{run,}ghc


# ldconfig for linker hack
# ghc-pkg describe base > base.package.conf
# sed -i "s/ld-options:/ld-options:\ -L\/app\/usr\/lib/" base.package.conf
# ghc-pkg update base.package.conf

# cabal-install
curl --slient http://hackage.haskell.org/package/cabal-install-1.18.0.2/cabal-install-1.18.0.2.tar.gz|tar xz
# curl --silent http://hackage.haskell.org/packages/archive/cabal-install/1.18.0.2/cabal-install-1.18.0.2.tar.gz|tar xz
cd cabal-install-1.18.0.2/
sh bootstrap.sh
cd ..

ln -s /.cabal/bin/cabal /usr/local/bin
# export PATH=$PATH:$HOME/.cabal

# Install a binary that Yesod needs separately
# cabal update
# cabal install happy
# find $HOME/.cabal -name "*HS*.o" -delete
# rm -rf $HOME/.cabal/{config,share,packages,logs}
# 
# tar cvzf ghc.tar.gz ghc
# tar cvzf cabal.tar.gz .cabal
