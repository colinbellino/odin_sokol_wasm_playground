mergeInto(LibraryManager.library, {
  $UTF8ToString__sig: 'ip', // Override the signature of UTF8ToString to use BigInt instead of Number

  wasm_write_string: (s_count, s_data, to_standard_error) => {
    // const string = js_string_from_jai_string(s_data, s_count);
    // write_to_console_log(string, to_standard_error);
    Module.print("wasm_write_string");
  },


  wasm_debug_break: () => {
    debugger;
  },
});