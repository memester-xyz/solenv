// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;
import "forge-std/Test.sol";
import {Decimal} from "../Decimal.sol";

contract DecimalTest is Test {
  using Decimal for uint;
  using Decimal for bytes;

  function testVagueOutputLength (uint i) public {
    assertLt(i.decimal().length, 79);
  }

  function testDecode(uint d) public {
    assertEq(d.decimal().decodeUint(), d);
  }
}
