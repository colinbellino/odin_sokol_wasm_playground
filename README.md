## Odin Sokol Wasm playground

Build the app: 
- `odin build src/ -out=odin -target:freestanding_wasm32 -debug -build-mode:obj -show-system-calls`
- `emcc -o index.html src/main.c odin.wasm.o src/sokol-odin/sokol/gfx/sokol_gfx_wasm_gl_debug.a src/sokol-odin/sokol/log/sokol_log_wasm_gl_debug.a src/sokol-odin/sokol/app/sokol_app_wasm_gl_debug.a src/sokol-odin/sokol/glue/sokol_glue_wasm_gl_debug.a -sERROR_ON_UNDEFINED_SYMBOLS=1 -sMAX_WEBGL_VERSION=2`