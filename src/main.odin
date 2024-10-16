package main

import "core:mem"
import "core:runtime"
import "core:fmt"
import sapp "sokol-odin/sokol/app"
import slog "sokol-odin/sokol/log"
import sg "sokol-odin/sokol/gfx"
import sglue "sokol-odin/sokol/glue"

ctx: runtime.Context
main_arena_buffer := [mem.Megabyte * 16]u8 {}
main_arena := mem.Arena { data = main_arena_buffer[:] }
frame_arena_buffer := [mem.Megabyte * 16]u8 {}
frame_arena := mem.Arena { data = frame_arena_buffer[:] }

pass_action: sg.Pass_Action

@(export) _main :: proc "c" () {
    ctx = runtime.default_context()
    context = ctx
    
    ctx.allocator = mem.arena_allocator(&main_arena)
    ctx.temp_allocator = mem.arena_allocator(&frame_arena)

    sapp.run({
        init_cb = init,
        frame_cb = frame,
        width = 960,
        height = 540,
        window_title = "clear",
        icon = { sokol_default = true },
        logger = { func = slog.func },
        html5_canvas_resize = false,
        high_dpi = true,
    })
}

init :: proc "c" () {
    context = ctx
    sg.setup({
        ctx = sglue.ctx(),
        logger = { func = slog.func },
    })
    pass_action.colors[0] = { load_action = .CLEAR, clear_value = { 1.0, 0.0, 0.0, 1.0 } }
}

frame :: proc "c" () {
    context = ctx
    g := pass_action.colors[0].clear_value.g + 0.01
    pass_action.colors[0].clear_value.g = g > 1.0 ? 0.0 : g
    sg.begin_default_pass(pass_action, sapp.width(), sapp.height())
    sg.end_pass()
    sg.commit()
}