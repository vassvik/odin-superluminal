# odin-superluminal

Odin bindings and wrapper for [Superluminal Performance](https://www.superluminal.eu/). This is achieved by making a thin C wrapper that around PerformanceAPI that is callable from Odin. Only the `BeginEvent` and `EndEvent` part of the API is available.

## Example

```go
package test 

import superluminal "shared:odin-superluminal"

import win32 "core:sys/win32"
import "core:fmt"

main :: proc() {
    foo :: proc() {
        superluminal.event("foo", "all");
        
        {
            superluminal.event("foo", "sleep");
            win32.sleep(1000);
        }
        
        {
            bar :: proc(a: int) {
                superluminal.event("bar", fmt.tprintf("a = %d", a));
                win32.sleep(1000);
            }

            superluminal.event("foo", "bars");
            bar(1);
            bar(2);
            bar(3);
        }
    }
    superluminal.event("main");
    foo();
}
```

![Example screenshot](screenshot.png)