// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;

import {Decimal} from "./Decimal.sol";
import {Hexadecimal} from "./Hexadecimal.sol";

library Mixed {
  function decodeMixedUint(bytes memory text) internal pure returns (uint) {
    if (Hexadecimal.isHexadecimal(text)) {
      text = Hexadecimal.decodeBytes(text);
      bytes memory nullPad = new bytes(32 - text.length);
      return abi.decode(
        bytes.concat(
          nullPad,
          text
        ),
        (uint)
      );
    } else {
      return Decimal.decodeUint(text);
    }
  }
}
