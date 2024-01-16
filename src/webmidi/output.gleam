import gleam/javascript/promise
import webmidi
import webmidi/internal
import webmidi/port

pub type Exception {
  TypeError(message: String)
  InvalidAccessError
  InvalidStateError
}

@external(javascript, "../ffi_webmidi.mjs", "send")
pub fn send(
  output: webmidi.MidiOutput,
  data: List(Int),
) -> Result(Nil, Exception)

pub fn clear(output: webmidi.MidiOutput) {
  internal.attr(output, "clear")()
}

pub fn id(port: webmidi.MidiOutput) -> String {
  internal.attr(port, "id")
}

pub fn manufacturer(port: webmidi.MidiOutput) -> String {
  internal.attr(port, "manufacturer")
}

pub fn name(port: webmidi.MidiOutput) -> String {
  internal.attr(port, "name")
}

pub fn type_(port: webmidi.MidiOutput) -> port.Type {
  case internal.attr(port, "type") {
    "input" -> port.Input
    "output" | _ -> port.Output
  }
}

pub fn version(port: webmidi.MidiOutput) -> String {
  internal.attr(port, "version")
}

pub fn state(port: webmidi.MidiOutput) -> port.State {
  case internal.attr(port, "state") {
    "disconnected" -> port.Disconnected
    "connected" | _ -> port.Connected
  }
}

pub fn connection(port: webmidi.MidiOutput) -> port.Connection {
  case internal.attr(port, "connection") {
    "open" -> port.Open
    "closed" -> port.Closed
    "pending" | _ -> port.Pending
  }
}

pub fn open(port: webmidi.MidiOutput) -> promise.Promise(Nil) {
  internal.attr(port, "open")()
}

pub fn closed(port: webmidi.MidiOutput) -> promise.Promise(Nil) {
  internal.attr(port, "closed")()
}

@external(javascript, "../ffi_webmidi.mjs", "on_state_change")
pub fn on_state_change(
  port: webmidi.MidiOutput,
  func: fn(webmidi.ConnectionEvent) -> Nil,
) -> Nil
