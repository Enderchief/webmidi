import gleam/javascript/promise

/// A MIDIInputMap instance is a read-only Map-like object, in which each key is the ID 
/// string for MIDI input, and the associated value is the corresponding MIDIInput object.
pub type MidiInputMap

// string for MIDI output, and the associated value is the corresponding MIDIOutput object.
/// A MIDIOutputMap instance is a read-only Map-like object, in which each key is the ID 
pub type MidiOutputMap

pub type MidiInput

pub type MidiOutput

pub type MidiAccess

pub type MidiPort

pub type ConnectionEvent

pub type MessageEvent

@external(javascript, "./ffi_webmidi.mjs", "request_midi")
pub fn request_midi() -> promise.Promise(MidiAccess)
