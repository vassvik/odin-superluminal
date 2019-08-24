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
                superluminal.event("bar", fmt.tprintf("a = %d\x00", a));
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