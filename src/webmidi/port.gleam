import gleam/javascript/promise
import webmidi
import webmidi/internal

pub type Type {
  Input
  Output
}

pub type State {
  Disconnected
  Connected
}

pub type Connection {
  Open
  Closed
  Pending
}

pub fn id(port: webmidi.MidiPort) -> String {
  internal.attr(port, "id")
}

pub fn manufacturer(port: webmidi.MidiPort) -> String {
  internal.attr(port, "manufacturer")
}

pub fn name(port: webmidi.MidiPort) -> String {
  internal.attr(port, "name")
}

pub fn type_(port: webmidi.MidiPort) -> Type {
  case internal.attr(port, "type") {
    "input" -> Input
    "output" | _ -> Output
  }
}

pub fn version(port: webmidi.MidiPort) -> String {
  internal.attr(port, "version")
}

pub fn state(port: webmidi.MidiPort) -> State {
  case internal.attr(port, "state") {
    "disconnected" -> Disconnected
    "connected" | _ -> Connected
  }
}

pub fn connection(port: webmidi.MidiPort) -> Connection {
  case internal.attr(port, "connection") {
    "open" -> Open
    "closed" -> Closed
    "pending" | _ -> Pending
  }
}

pub fn open(port: webmidi.MidiPort) -> promise.Promise(Nil) {
  internal.attr(port, "open")()
}

pub fn closed(port: webmidi.MidiPort) -> promise.Promise(Nil) {
  internal.attr(port, "closed")()
}

@external(javascript, "../ffi_webmidi.mjs", "on_state_change")
pub fn on_state_change(
  port: webmidi.MidiPort,
  func: fn(webmidi.ConnectionEvent) -> Nil,
) -> Nil
