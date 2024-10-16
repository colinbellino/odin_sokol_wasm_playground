#!/bin/bash

pwd=$(pwd)
# target="freestanding_wasm32"
# mode="debug"
# dist=dist/"$target"_"$mode"
dist="dist/"

mkdir -p $dist
cd $pwd
jai first.jai
cd $dist
emcc -o index.html -sERROR_ON_UNDEFINED_SYMBOLS=1 -sMEMORY64 -sMAX_WEBGL_VERSION=2 $pwd/src/main.c main.o $pwd/modules/sokol-jai/sokol/gfx/sokol_gfx_wasm_gl_debug.a $pwd/modules/sokol-jai/sokol/log/sokol_log_wasm_gl_debug.a $pwd/modules/sokol-jai/sokol/app/sokol_app_wasm_gl_debug.a $pwd/modules/sokol-jai/sokol/glue/sokol_glue_wasm_gl_debug.a --js-library=../wtf.js
echo "Done."