// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.13;

import {Decimal} from "./Decimal.sol";
import {Hexadecimal} from "./Hexadecimal.sol";
import {Quote} from "./Quote.sol";

/**
 * @author evmgolf
 * @dev JSON encoder
 */
library JSON {
  using Decimal for uint;
  using Hexadecimal for address;
  using Hexadecimal for bytes;
  using Quote for bytes;

  function quote(bytes memory text) internal pure returns (bytes memory) {
    return text.quote('"');
  }

  function encode() internal pure returns (bytes memory text) {
    text = "null";
  }

  function encode(bool value) internal pure returns (bytes memory text) {
    text = bytes(value ? "true" : "false");
  }

  function encode(uint value) internal pure returns (bytes memory text) {
    text = value.decimal();
  }

  function encode(address value) internal pure returns (bytes memory text) {
    text = quote(value.hexadecimal());
  }

  function encode(bytes memory value) internal pure returns (bytes memory text) {
    text = quote(value.hexadecimal());
  }

  function encode(string memory value) internal pure returns (bytes memory text) {
    text = quote(bytes(value));
  }

  function encode(bytes[] memory values) internal pure returns (bytes memory text) {
    text = "[";
    if (values.length > 0) {
      text = bytes.concat(text, values[0]);
    }
    for (uint i=1;i<values.length;i++) {
      text = bytes.concat(text, ",", values[i]);
    }
    text = bytes.concat(text, "]");
  }

  function encode(bytes[] memory keys, bytes[] memory values) internal pure returns (bytes memory text) {
    text = "{";

    if (keys.length > 0) {
      text = bytes.concat(
          text,
          quote(keys[0]),
          ":",
          values[0]
      );
    }
    for (uint i=1; i<keys.length;i++) {
      text = bytes.concat(
          text,
          ",",
          quote(keys[i]),
          ":",
          values[i]
      );
    }
    text = bytes.concat(text, "}");
  }
}
