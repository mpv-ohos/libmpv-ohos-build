#!/bin/bash

set -eu

ROOT_DIR=$(cd $(dirname "$0")/..; pwd)

. $ROOT_DIR/env.sh

pushd $ROOT_DIR/libmpv/mpv

if [ "$1" == "build" ]; then
	echo -e "\nBuilding mpv..."
elif [ "$1" == "clean" ]; then
	rm -rf .build
	exit 0
else
	exit 1
fi

mkdir -p .build
cd .build

meson setup .. \
  --cross-file $ROOT_DIR/libmpv/arm64-crossfile.ini \
  --prefix=$DEST/mpv \
  --default-library shared \
  --strip \
  -Dopensles=disabled \
  -Dohos=enabled \
  -Degl-ohos=enabled \
  -Dvulkan=enabled \
  -Dshaderc=enabled \
  -Dlua=enabled \
  -Dgpl=false \
  -Dbuild-date=false \
  -Dcplayer=false \
  -Dmanpage-build=disabled
ninja -j$CORES
ninja install

cd $DEST/mpv/lib
mv libmpv.so ../../libmpv.so

popd