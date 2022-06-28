// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;

import "forge-std/Test.sol";
import {Mixed} from "../Mixed.sol";
import {Hexadecimal} from "../Hexadecimal.sol";
import {Decimal} from "../Decimal.sol";

contract MixedTest is Test {
  using Mixed for bytes;
  using Hexadecimal for uint;
  using Decimal for uint;

  function testDecodeMixedUint(uint n) public {
    assertEq(n.hexadecimal().decodeMixedUint(), n);
    assertEq(n.decimal().decodeMixedUint(), n);
  }
}
