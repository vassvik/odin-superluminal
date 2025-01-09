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