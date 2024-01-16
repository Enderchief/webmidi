// @ts-check

// @ts-expect-error
import { Error, Ok, BitArray, List } from "../prelude.mjs";
import {
    InvalidAccessError,
    InvalidStateError,
    TypeError,
// @ts-expect-error
} from "./webmidi/output.mjs";

/**
 * @param {MIDIInputMap | MIDIOutputMap} map
 * @param {string} key
 */
export function get(map, key) {
  return toResult(map.get(key));
}

/**
 * @param {MIDIInputMap | MIDIOutputMap} map
 * @param {string} key
 */
export function has(map, key) {
  return map.has(key);
}

/**
 * @param {MIDIInputMap | MIDIOutputMap} map
 */
export function size(map) {
  return map.size;
}

/**
 * @param {MIDIInputMap | MIDIOutputMap} _map
 * @param {(k: string, v: MIDIInput | MIDIOutput) => any} fun
 */
export function map(_map, fun) {
  const _res = [];
  for (const [k, v] of _map.entries()) {
    _res.push(fun(k, v));
  }
  return _res;
}

/**
 * @param {MIDIAccess} access
 */
export function inputs(access) {
  return access.inputs;
}

/**
 * @param {MIDIAccess} access
 */
export function outputs(access) {
  return access.outputs;
}

/**
 * @param {MIDIAccess} access
 */
export function sysex_enabled(access) {
  return access.sysexEnabled;
}

/**
 * @param {MIDIAccess | MIDIPort} access
 * @param {(event: MIDIConnectionEvent) => void} func
 */
export function on_state_change(access, func) {
  // @ts-expect-error: type is correct
  return access.addEventListener("statechange", (ev) => func(ev));
}

/**
 * @param {MIDIConnectionEvent} event
 */
export function port(event) {
  return event.port;
}

/**
 * @param {MIDIInput} input
 * @param {(v: MIDIMessageEvent) => void} func
 */
export function on_midi_message(input, func) {
  // @ts-expect-error: type is correct
  return input.addEventListener("midimessage", (ev) => func(ev));
}

/**
 * @param {MIDIMessageEvent} event
 */
export function data(event) {
  return new BitArray(event.data);
}

/**
 * @param {MIDIOutput} output
 * @param {List<number>} data
 */
export function send(output, data) {
  try {
    output.send(data);
  } catch (e) {
    if (e instanceof DOMException) {
      switch (e.name) {
        case "InvalidAccessError":
          return new InvalidAccessError();
        case "InvalidStateError":
          return new InvalidStateError();
      }
    } else if (e instanceof globalThis.TypeError) {
      return new TypeError(e.message);
    }
  }
}

export function request_midi() {
  return navigator.requestMIDIAccess();
}

export function attr(obj, attr) {
  return obj[attr];
}

/**
 * @param {any} input
 */
function toResult(input) {
  if (typeof input === "undefined" || isNaN(input)) {
    return new Error(input);
  }
  return new Ok(input);
}
