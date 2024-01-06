#!/usr/bin/env bash

set -ex

mkdir -p build
cd build

cmake .. \
  ${CMAKE_ARGS} \
  -G Ninja \
  -D INSTALL_MODULES=ON
cmake --build .
cmake --install .

for mode in activate deactivate
do
  mkdir -p "${CONDA_PREFIX}/share/${mode}.d"
  cp \
    "${RECIPE_DIR}/script/${mode}.sh" \
    "${CONDA_PREFIX}/share/${mode}.d/${PKGNAME}-${mode}.sh"
done

