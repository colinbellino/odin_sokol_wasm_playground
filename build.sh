#!/bin/bash

pwd=$(pwd)
target="freestanding_wasm32"
mode="debug"
dist=dist/"$target"_"$mode"

mkdir -p $dist
cd $dist
odin build $pwd/src/main.odin -file -out=odin -build-mode:obj -disable-assert -no-bounds-check -show-system-calls -debug --target:$target $1 &&
emcc -o index.html -sERROR_ON_UNDEFINED_SYMBOLS=1 -sMAX_WEBGL_VERSION=2 $pwd/src/main.c odin.wasm.o $pwd/src/sokol-odin/sokol/gfx/sokol_gfx_wasm_gl_debug.a $pwd/src/sokol-odin/sokol/log/sokol_log_wasm_gl_debug.a $pwd/src/sokol-odin/sokol/app/sokol_app_wasm_gl_debug.a $pwd/src/sokol-odin/sokol/glue/sokol_glue_wasm_gl_debug.a
echo "Done."