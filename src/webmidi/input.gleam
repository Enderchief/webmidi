import gleam/javascript/promise
import webmidi
import webmidi/internal
import webmidi/port

@external(javascript, "../ffi_webmidi.mjs", "on_midi_message")
pub fn on_midi_message(
  input: webmidi.MidiInput,
  func func: fn(webmidi.MessageEvent) -> Nil,
) -> Nil

pub fn id(port: webmidi.MidiInput) -> String {
  internal.attr(port, "id")
}

pub fn manufacturer(port: webmidi.MidiInput) -> String {
  internal.attr(port, "manufacturer")
}

pub fn name(port: webmidi.MidiInput) -> String {
  internal.attr(port, "name")
}

pub fn type_(port: webmidi.MidiInput) -> port.Type {
  case internal.attr(port, "type") {
    "input" -> port.Input
    "output" | _ -> port.Output
  }
}

pub fn version(port: webmidi.MidiInput) -> String {
  internal.attr(port, "version")
}

pub fn state(port: webmidi.MidiInput) -> port.State {
  case internal.attr(port, "state") {
    "disconnected" -> port.Disconnected
    "connected" | _ -> port.Connected
  }
}

pub fn connection(port: webmidi.MidiInput) -> port.Connection {
  case internal.attr(port, "connection") {
    "open" -> port.Open
    "closed" -> port.Closed
    "pending" | _ -> port.Pending
  }
}

pub fn open(port: webmidi.MidiInput) -> promise.Promise(Nil) {
  internal.attr(port, "open")()
}

pub fn closed(port: webmidi.MidiInput) -> promise.Promise(Nil) {
  internal.attr(port, "closed")()
}

@external(javascript, "../ffi_webmidi.mjs", "on_state_change")
pub fn on_state_change(
  port: webmidi.MidiInput,
  func: fn(webmidi.ConnectionEvent) -> Nil,
) -> Nil
