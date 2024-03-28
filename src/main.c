#include <emscripten/emscripten.h>
#include <emscripten/html5.h>

extern void _main();
extern void _step();

int main() {
    _main();
    // emscripten_set_main_loop(_step, 0, 1);
    return 0;
}