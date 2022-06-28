// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;
import "forge-std/Test.sol";
import {Hexadecimal} from "../Hexadecimal.sol";
import {Tokenizer} from "../Tokenizer.sol";

contract TokenizerTest is Test {
  using Hexadecimal for uint;
  using Tokenizer for bytes;

  function testCount () public {
    assertEq(uint(0).hexadecimal().count("0"), 3);
    assertEq(uint(0).hexadecimal().count("0x00"), 1);
    assertEq(type(uint).max.hexadecimal().count("f"), 64);
    assertEq(type(uint).max.hexadecimal().count("0x"), 1);
  }

  function testCount (uint i) public {
    assertEq(i.hexadecimal().count("x"), 1);
    assertEq(i.hexadecimal().count("0x"), 1);
  }

  function testSplit (uint i) public {
    bytes[] memory results = i.hexadecimal().split("x");
    assertEq(results.length, 2);
    assertEq(results[0], "0");
    assertGt(results[1].length, 1);
  }

}
