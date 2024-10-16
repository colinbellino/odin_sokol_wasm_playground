#import "Basic";
#import,dir "modules/sokol-jai/sokol/app";
#import,dir "modules/sokol-jai/sokol/gfx";
#import,dir "modules/sokol-jai/sokol/glue";
#import,dir "modules/sokol-jai/sokol/log";

ctx: Context;
pass_action: sg_pass_action;

// TODO: Logger (browser console)
// TODO: Replace ugly index.html template
// FIXME: Implement wasm_write_string in wtf.js

#program_export
_main :: () #c_call {
    push_context,defer_pop ctx;
    // context.logger = logger;

    sapp_run(*(sapp_desc.{
        init_cb = init,
        frame_cb = frame,
        width = 960,
        height = 540,
        window_title = "clear",
        // icon = .{ sokol_default = true },
        logger = .{ func = slog_func },
        html5_canvas_resize = false,
        high_dpi = true,
    }));
}


#program_export
_step :: () #c_call {

}

init :: () #c_call {
    push_context,defer_pop ctx;
    sg_setup(*(sg_desc.{
        environment = xx sglue_environment(),
        logger = .{ func = slog_func },
    }));
    pass_action.colors[0] = .{ load_action = .CLEAR, clear_value = .{ 1.0, 0.0, 0.0, 1.0 } };
}

frame :: () #c_call {
    push_context,defer_pop ctx;
    g := pass_action.colors[0].clear_value.g + 0.01;
    pass_action.colors[0].clear_value.g = ifx(g > 1.0) then 0.0 else g;
    sg_begin_pass(*(sg_pass.{ action = pass_action, swapchain = xx sglue_swapchain() }));
    sg_end_pass();
    sg_commit();
}