set -e

build_lib_wasm_release() {
    src=$1
    dst=$2
    backend=$3
    echo $dst
    emcc -c -O2 -DNDEBUG -DIMPL -D$backend c/$src.c
    emar rcs $dst.a $src.o
}

build_lib_wasm_debug() {
    src=$1
    dst=$2
    backend=$3
    echo $dst
    emcc -c -g -DIMPL -D$backend c/$src.c
    emar rcs $dst.a $src.o
}

# wasm + GL + Release
build_lib_wasm_release sokol_gfx sokol/gfx/sokol_gfx_wasm_gl_release SOKOL_GLES3
build_lib_wasm_release sokol_app sokol/app/sokol_app_wasm_gl_release SOKOL_GLES3

# wasm + GL + Debug
build_lib_wasm_debug sokol_gfx sokol/gfx/sokol_gfx_wasm_gl_debug SOKOL_GLES3
build_lib_wasm_debug sokol_app sokol/app/sokol_app_wasm_gl_debug SOKOL_GLES3

rm *.o
