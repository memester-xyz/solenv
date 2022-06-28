// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;

library Quote {
  function quote(bytes memory text, bytes memory quoter) internal pure returns (bytes memory) {
    return bytes.concat(quoter, text, quoter);
  }
}
