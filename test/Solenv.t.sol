// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Solenv} from "src/Solenv.sol";

contract SolenvTest is Test {
    function setUp() public {}

    function testEnvLoad() public {
        Solenv.config();

        assertEq(vm.envString("WHY_USE_THIS_KEY"), "because we can can can");
        assertEq(vm.envString("SOME_VERY_IMPORTANT_API_KEY"), "omgnoway");
        assertEq(vm.envString("A_COMPLEX_ENV_VARIABLE"), "y&2U9xiEINv!vM8Gez");

        assertEq(vm.envUint("A_NUMBER"), 100);

        assertEq(vm.envBool("A_TRUE_BOOL"), true);
        assertEq(vm.envBool("A_FALSE_BOOL"), false);

        assertEq(vm.envBool("A_FALSE_BOOL"), false);

        assertEq(vm.envAddress("AN_ADDRESS"), 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);

        assertEq(vm.envBytes32("A_BYTES_32"), 0x0000000000000000000000000000000000000000000000000000000000000010);
    }

    function testAnotherFileName() public {
        Solenv.config(".env.test");

        assertEq(vm.envString("SOME_VERY_IMPORTANT_API_KEY"), "adifferentone");
    }
}

contract SolenvInSetupTest is Test {
    function setUp() public {
        Solenv.config();
    }

    function testEnvLoad() public {
        assertEq(vm.envString("WHY_USE_THIS_KEY"), "because we can can can");
        assertEq(vm.envString("SOME_VERY_IMPORTANT_API_KEY"), "omgnoway");
        assertEq(vm.envString("A_COMPLEX_ENV_VARIABLE"), "y&2U9xiEINv!vM8Gez");

        assertEq(vm.envUint("A_NUMBER"), 100);

        assertEq(vm.envBool("A_TRUE_BOOL"), true);
        assertEq(vm.envBool("A_FALSE_BOOL"), false);

        assertEq(vm.envBool("A_FALSE_BOOL"), false);

        assertEq(vm.envAddress("AN_ADDRESS"), 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);

        assertEq(vm.envBytes32("A_BYTES_32"), 0x0000000000000000000000000000000000000000000000000000000000000010);
    }
}
