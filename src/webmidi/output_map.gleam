import webmidi

@external(javascript, "../ffi_webmidi.mjs", "get")
pub fn get(
  output_map: webmidi.MidiOutputMap,
  key key: String,
) -> Result(webmidi.MidiOutput, Nil)

@external(javascript, "../ffi_webmidi.mjs", "has")
pub fn has(output_map: webmidi.MidiOutputMap, key key: String) -> Bool

@external(javascript, "../ffi_webmidi.mjs", "size")
pub fn size(output_map: webmidi.MidiOutputMap, key key: String) -> Int

@external(javascript, "../ffi_webmidi.mjs", "map")
pub fn map(
  output_map: webmidi.MidiOutputMap,
  with fun: fn(String, webmidi.MidiOutput) -> a,
) -> a
