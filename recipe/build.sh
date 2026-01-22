#!/bin/bash

set -ex

cd Build

cmake ${CMAKE_ARGS}              \
      -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_SHARED_LIBS=ON     \
      -DBUILD_TESTING=OFF        \
      -DNATIVE=OFF               \
      ..

make -j${CPU_COUNT} VERBOSE=1
# Tests are skipped due to the fact that they hang at the very beginning
# ctest --output-on-failure
make install
