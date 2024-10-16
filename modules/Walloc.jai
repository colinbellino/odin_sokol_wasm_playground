#scope_module

walloc_malloc :: (size: s64) -> *void #foreign "malloc"; // Will be provided by WASM
walloc_free :: (p: *void) #foreign "free"; // Will be provided by WASM

#scope_export

walloc_allocator :: Allocator.{allocator_proc, null};

allocator_proc :: (mode: Allocator_Mode, requested_size: s64, old_size: s64, old_memory: *void, allocator_data: *void) -> *void {
    if #complete mode == {
        case .STARTUP;      #through;
        case .SHUTDOWN;     #through;
        case .THREAD_START; #through;
        case .THREAD_STOP;
            return null;

        case .ALLOCATE; #through;
        case .RESIZE;
            // @TODO: Can we support proper realloc?
            result := walloc_malloc(requested_size);
            if mode == .RESIZE {
                size_to_copy := min(old_size, requested_size);
                if result && size_to_copy memcpy(result, old_memory, size_to_copy);
            }
            return result;

        case .FREE;
            log("[Walloc]: FREE");
            walloc_free(old_memory);
            return null;

        case .CREATE_HEAP; #through;
        case .DESTROY_HEAP;
            context.handling_assertion_failure = true;
            context.assertion_failed(#location(), "This allocator does not support multiple heaps.\n");
            context.handling_assertion_failure = false;
            return null;


        case .IS_THIS_YOURS;
            context.handling_assertion_failure = true;
            context.assertion_failed(#location(), "This allocator does not support IS_THIS_YOURS.\n");
            context.handling_assertion_failure = false;
            return null;

        case .CAPS;
            if old_memory { <<cast(*string)old_memory = CAPS_VERSION_STRING; }
            return cast(*void) (Allocator_Caps.HINT_I_AM_A_GENERAL_HEAP_ALLOCATOR|.MULTIPLE_THREADS|.FREE|.ACTUALLY_RESIZE);

        case;
            context.handling_assertion_failure = true;
            context.assertion_failed(#location(), "Invalid or corrupt mode passed to Walloc.allocator_proc().\n");
            context.handling_assertion_failure = false;
            return null;
    }
}

#scope_file

CAPS_VERSION_STRING :: "Walloc";

#import "Basic";
