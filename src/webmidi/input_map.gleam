import webmidi

@external(javascript, "../ffi_webmidi.mjs", "get")
pub fn get(
  input_map: webmidi.MidiInputMap,
  key key: String,
) -> Result(webmidi.MidiInput, Nil)

@external(javascript, "../ffi_webmidi.mjs", "has")
pub fn has(input_map: webmidi.MidiInputMap, key key: String) -> Bool

@external(javascript, "../ffi_webmidi.mjs", "size")
pub fn size(input_map: webmidi.MidiInputMap, key key: String) -> Int

@external(javascript, "../ffi_webmidi.mjs", "map")
pub fn map(
  input_map: webmidi.MidiInputMap,
  with fun: fn(String, webmidi.MidiInput) -> a,
) -> a
