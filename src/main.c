#include <emscripten/emscripten.h>
#include <emscripten/html5.h>

extern void _main();

int main() {
    _main();
    return 0;
}