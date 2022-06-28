// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;
import "forge-std/Test.sol";
import {JSON} from "../JSON.sol";

contract JSONTest is Test {
  function testEncodeNullSucceeds() public {
    JSON.encode();
  }

  function testEncodeUintSucceeds(uint value) public {
    JSON.encode(value);
  }

  function testEncodeAddressSucceeds(address value) public {
    JSON.encode(value);
  }

  function testEncodeBytesSucceeds(bytes memory value) public {
    JSON.encode(value);
  }

  function testEncodeStringSucceeds(string memory value) public {
    JSON.encode(value);
  }

  function testEncodeArraySucceeds(bytes[] memory values) public {
    JSON.encode(values);
  }

  function testEncodeObjectSucceeds(bytes[] memory keys, bytes[] memory values) public {
    if (values.length < keys.length) {
      return;
    }
    JSON.encode(keys, values);
  }
}
