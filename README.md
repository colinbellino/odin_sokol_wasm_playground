## Odin Sokol WASM playground

Build the app: 
- Run `./build.sh`. (Outputs in dist/freestanding_wasm_debug by default).
- Serve the folder. (Something like `python -m http.server 8080 --bind 127.0.0.1 --directory ./dist/freestanding_wasm32_debug/`, but any tool that can app serve static assets should work.)
- Open in a browser. (http://127.0.0.1:8080 for example)