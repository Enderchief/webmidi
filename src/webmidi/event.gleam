import webmidi

@external(javascript, "../ffi_webmidi.mjs", "port")
pub fn connection_port(event: webmidi.ConnectionEvent) -> webmidi.MidiPort

@external(javascript, "../ffi_webmidi.mjs", "data")
pub fn message_data(event: webmidi.MessageEvent) -> BitArray
