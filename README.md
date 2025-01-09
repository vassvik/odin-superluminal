# odin-superluminal

Odin bindings for [Superluminal Performance](https://www.superluminal.eu/)'s instrumentation API called PerformanceAPI.

Includes a copy of the header files for documentation purposes and one of the library files for Windows for easy integration, as of Superluminal Performance 1.0.6470.3335, which corresponds to PerformanceAPI version 3.0. 

## Instructions

In Windows:

```batch
cd /path/to/Odin/shared
git clone https://github.com/vassvik/odin-superluminal.git
```

Now simply add `import "shared:superluminal"` in the files you want to add instrumentation to and call `InstrumentationScope` wherever you want. 

Compile your exe and run it in Superluminal Performance, and everything should just work. 

To get function names other than the scopes defined by the instrumentation API you should compile with `-debug`. 



## API

```odin
// The following are direct C-bindings
BeginEvent_N :: proc(inID: [^]u8, inIDLength: u16, inData: [^]u8, inDataLength: u16, inColor: u32) ---;
EndEvent     :: proc() -> SuppressTailCallOptimization ---;

SetCurrentThreadName_N :: proc(inThreadName: [^]u8, inThreadNameLength: u16) ---;

RegisterFiber    :: proc(inFiberID: u64) ---;
UnregisterFiber  :: proc(inFiberID: u64) ---;
BeginFiberSwitch :: proc(inCurrentFiberID, inNewFiberID: u64) ---;
EndFiberSwitch   :: proc(inFiberID: u64) ---;


// This is a port of the MAKE_COLOR macro
MAKE_COLOR :: #force_inline proc(r, g, b: u8) -> u32

// This is a helper that roughly maps to the usage of the InstrumentationScope class in PerformanceAPI.h
// It calls EndEvent when it next goes out of scope
InstrumentationScope :: proc(inID: string, inData: string = "", inColor: u32 = DEFAULT_COLOR)

// This is a wrapper around SetCurrentThreadName_N so we can simply just pass an Odin-string
SetCurrentThreadName :: proc(inThreadName: string)
```

See `include/PerformanceAPI_capi.h` and `include/PerformanceAPI.h` for more details and options. 

## Example

```go
package test

import "core:fmt"
import "core:math/rand"
import superluminal "shared:odin-superluminal"

main :: proc() {
	superluminal.InstrumentationScope("Main")

	for i in 0..<10 {
		superluminal.InstrumentationScope("Outer", fmt.tprintf("i=%d", i))
		for j in 1..<10 {
			superluminal.InstrumentationScope("Inner", fmt.tprintf("j=%d", j))
			sum := f32(0.0)
			{
				superluminal.InstrumentationScope("Sum", fmt.tprintf("i=%d j=%d", i, j))
				for k in 0..<j*1_000_000 {
					sum += rand.float32()
				}
			}
			fmt.println(sum)
		}
	}
	fmt.println("Done")
}
```
![image](https://github.com/user-attachments/assets/30e5d59b-d7c6-49b2-8722-1cfddc88c254)
