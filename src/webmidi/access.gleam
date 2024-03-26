import webmidi
import webmidi/internal

pub fn inputs(access: webmidi.MidiAccess) -> webmidi.MidiInputMap {
  internal.attr(access, "inputs")
}

pub fn outputs(access: webmidi.MidiAccess) -> webmidi.MidiOutputMap {
  internal.attr(access, "outputs")
}

pub fn sysex_enabled(access: webmidi.MidiAccess) -> Bool {
  internal.attr(access, "synexEnabled")
}

@external(javascript, "../ffi_webmidi.mjs", "on_state_change")
pub fn on_state_change(
  access: webmidi.MidiAccess,
  func: fn(webmidi.ConnectionEvent) -> Nil,
) -> Nil
