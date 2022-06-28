// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;
import "forge-std/Test.sol";
import {Base64} from "../Base64.sol";

contract Base64Test is Test {
  using Base64 for bytes;

  function testOutputsSomething(bytes calldata input) public {
    if (input.length == 0) {
      assertEq(input.base64(), input);
    } else {
      assertGt(input.base64().length, 0);
    }
  }
}
