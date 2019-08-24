package superluminal

foreign import superluminal { "lib/superluminal.lib" };

foreign superluminal {
    begin_event :: proc(inID: cstring) ---;
	begin_event_data :: proc(inID, inData: cstring) ---;
	end_event :: proc() ---;
}

@(deferred_none=end_event)
event_id :: proc(inID: string) {
	begin_event(cast(cstring)&inID[0]);
}

@(deferred_none=end_event)
event_id_and_data :: proc(inID, inData: string) {
	begin_event_data(cast(cstring)&inID[0], cast(cstring)&inData[0]);
}

event :: proc{event_id, event_id_and_data};