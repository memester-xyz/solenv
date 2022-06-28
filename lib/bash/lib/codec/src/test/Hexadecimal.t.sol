// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;
import "forge-std/Test.sol";
import {Hexadecimal} from "../Hexadecimal.sol";

contract HexadecimalTest is Test {
  using Hexadecimal for uint;
  using Hexadecimal for address;
  using Hexadecimal for bytes;

  function testVagueOutputLength (uint i) public {
    assertLt(i.hexadecimal().length, 67);
  }

  function testOutputLength (address a) public {
    assertEq(a.hexadecimal().length, 42);
  }

  function testOutputLength (bytes calldata text) public {
    assertEq(text.hexadecimal().length, 2 * (text.length + 1));
  }

  function testSpecificHexadecimalText() public {
    assertEq0(bytes("").hexadecimal(), "0x");
    assertEq0(bytes("abcd").hexadecimal(), "0x61626364");
  }

  function testDecodeBytes(bytes memory text) public {
    if (text.length == 0) {
      return;
    }
    assertEq0(text.hexadecimal().decodeBytes(), text);
  }

  function testDecodeAddress(address a) public {
    assertEq(a.hexadecimal().decodeAddress(), a);
  }
}
