package superluminal

// Can use -extra-linker-flags:"/ignore:4099" to suppress 
//
//     warning LNK4099: PDB '' was not found with 'performanceapi_mt.lib(PerformanceAPI.obj)' or at ''; linking object as if no debug info
//
foreign import superluminal { "lib/PerformanceAPI_MT.lib" };

SuppressTailCallOptimization :: struct {
	SuppressTrailCall: [3]i64,
}

// See include/PerformanceAPI_capi.h for documentation, and if you need
// some of the more specialized functions
@(default_calling_convention="c", link_prefix="PerformanceAPI_")
foreign superluminal {
    BeginEvent_N :: proc(inID: [^]u8, inIDLength: u16, inData: [^]u8, inDataLength: u16, inColor: u32) ---;
	EndEvent     :: proc() -> SuppressTailCallOptimization ---;

	SetCurrentThreadName_N :: proc(inThreadName: [^]u8, inThreadNameLength: u16) ---;
	
	RegisterFiber    :: proc(inFiberID: u64) ---;
	UnregisterFiber  :: proc(inFiberID: u64) ---;
	BeginFiberSwitch :: proc(inCurrentFiberID, inNewFiberID: u64) ---;
	EndFiberSwitch   :: proc(inFiberID: u64) ---;

}

DEFAULT_COLOR :: 0xFFFFFFFF

MAKE_COLOR :: #force_inline proc(r, g, b: u8) -> u32 {
	return transmute(u32)[4]u8{0xFF, b, g, r}
}

@(deferred_none=EndEvent)
InstrumentationScope :: proc(inID: string, inData: string = "", inColor: u32 = DEFAULT_COLOR) {
	BeginEvent_N(raw_data(inID), u16(len(inID)), raw_data(inData), u16(len(inData)), inColor)
}

SetCurrentThreadName :: proc(inThreadName: string) {
	SetCurrentThreadName_N(raw_data(inThreadName), u16(len(inThreadName)))
}