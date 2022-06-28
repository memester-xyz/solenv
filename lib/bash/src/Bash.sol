// SPDX-License-Identifier: BSD-3-Clause
pragma solidity 0.8.13;

import {Script} from "forge-std/Script.sol";
import {Decimal} from "codec/Decimal.sol";

contract Bash is Script {
  function run(bytes memory script) external returns (bytes memory) {
    string[] memory args = new string[](3);
    args[0] = "bash";
    args[1] = "-c";
    args[2] = string(script);
    return vm.ffi(args);
  }
  function run(bytes memory script, bytes memory filename) external returns (bytes memory) {
    string[] memory args = new string[](3);
    args[0] = "bash";
    args[1] = "-c";
    args[2] = string(bytes.concat(script, " >", filename));
    return vm.ffi(args);
  }
}
