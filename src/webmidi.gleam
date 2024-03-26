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

//#TODO: Finish adding all events
pub type MidiData {
  NoteOff(channel: Int, pitch: Int, velocity: Int)
  NoteOn(channel: Int, pitch: Int, velocity: Int)
  PolyPressure(channel: Int, pitch: Int, pressure: Int)
  BankSelect(channel: Int, value: Int)
  Modulation(channel: Int, value: Int)
  BreathController(channel: Int, value: Int)
  Undefined1(channel: Int, value: Int)
  FootController(channel: Int, value: Int)
  PortamentoTime(channel: Int, value: Int)
  // DataEntry
  ChannelVolume(channel: Int, value: Int)
  Balance(channel: Int, value: Int)
  Undefined2(channel: Int, value: Int)
  Pan(channel: Int, value: Int)
  ExpressionController(channel: Int, value: Int)

  // ----------------
  SongSelect(id: Int)
  TuneRequest
  EndOfSysEx
  Timing
  Start
  Continue
  Stop
  ActiveSensing
  SystemReset
  // ----
  Undefined(value: Int)
  Err(value: BitArray)
}

pub fn to_data(raw: BitArray) {
  case raw {
    <<channel, pitch, velocity>> if 128 <= channel && channel <= 143 -> {
      NoteOff(channel - 128, pitch, velocity)
    }
    <<channel, pitch, velocity>> if 144 <= channel && channel <= 159 -> {
      NoteOn(channel - 144, pitch, velocity)
    }
    <<channel, pitch, pressure>> if 160 <= channel && channel <= 175 -> {
      PolyPressure(channel - 160, pitch, pressure)
    }
    <<channel, 0, value>> if 176 <= channel && channel <= 191 -> {
      BankSelect(channel - 176, value)
    }
    <<channel, 1, value>> if 176 <= channel && channel <= 191 -> {
      Modulation(channel - 176, value)
    }
    <<channel, 2, value>> if 176 <= channel && channel <= 191 -> {
      BreathController(channel - 176, value)
    }
    // <<channel, 3, value>> if 176 <= channel && channel <= 191 -> {
    //   _(channel - 176, value)
    // }
    <<channel, 4, value>> if 176 <= channel && channel <= 191 -> {
      FootController(channel - 176, value)
    }
    <<channel, 5, value>> if 176 <= channel && channel <= 191 -> {
      PortamentoTime(channel - 176, value)
    }
    // <<channel, 6, value>> if 176 <= channel && channel <= 191 -> {
    //   (channel - 176, value)
    // }
    <<channel, 7, value>> if 176 <= channel && channel <= 191 -> {
      ChannelVolume(channel - 176, value)
    }
    <<channel, 8, value>> if 176 <= channel && channel <= 191 -> {
      Balance(channel - 176, value)
    }
    // <<channel, 9, value>> if 176 <= channel && channel <= 191 -> {
    //   _(channel - 176, value)
    // }
    // -----
    <<243, id>> -> SongSelect(id)
    <<246>> -> TuneRequest
    <<247>> -> EndOfSysEx
    <<248>> -> Timing
    <<249, value>> -> Undefined(value)
    <<250>> -> Start
    <<251>> -> Continue
    <<252>> -> Stop
    <<254>> -> ActiveSensing
    <<255>> -> SystemReset

    _ -> Err(raw)
  }
}
