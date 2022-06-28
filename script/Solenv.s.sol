// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {Solenv} from "src/Solenv.sol";

contract SolenvScript is Script {
    function setUp() public {
        Solenv.config();
    }

    function run() public {
        vm.broadcast();
    }
}
