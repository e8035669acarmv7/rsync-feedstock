#!/bin/sh
# Get an updated config.sub and config.guess
cp $BUILD_PREFIX/share/gnuconfig/config.* .

set -e -o pipefail

# If platform detection fails, these should be updated in the meta.yaml from:
# http://git.savannah.gnu.org/gitweb/?p=config.git&view=view+git+repository
mv config-updated.guess config.guess
mv config-updated.sub config.sub

./configure --prefix=$PREFIX --without-included-zlib --without-included-popt
make
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
make check
fi
make install
