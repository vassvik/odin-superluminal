#include "../include/PerformanceAPI.h"

extern "C" void begin_event(const char* inID);
extern "C" void begin_event_data(const char* inID, const char* inData);
extern "C" void end_event();

void begin_event(const char* inID) {
	PerformanceAPI::BeginEvent(inID);
}

void begin_event_data(const char* inID, const char* inData) {
	PerformanceAPI::BeginEvent(inID, inData);
}

void end_event() {
	PerformanceAPI::EndEvent();
}