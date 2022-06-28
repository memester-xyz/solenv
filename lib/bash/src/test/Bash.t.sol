// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;

import "forge-std/Test.sol";
import {Decimal} from "codec/Decimal.sol";
import {Bash} from "../Bash.sol";

contract BashTest is Test {
  using Decimal for uint;
  Bash bash;

  function setUp() public {
    bash = new Bash();
  }

  function testEcho(uint data) public {
    uint result = abi.decode(bash.run(bytes.concat("echo ", data.decimal(), "|cast --to-uint256")), (uint));
    assertEq(result, data);
  }

  function testWrite(uint data) public {
    bytes memory filename = bytes.concat("/tmp/", data.decimal());
    bash.run(bytes.concat("echo ", data.decimal()), filename);
    uint result = abi.decode(bash.run(bytes.concat("cat ", filename, "|cast --to-uint256")), (uint));
    assertEq(result, data);
  }
}
