// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Solenv} from "src/Solenv.sol";

library SolenvHelper {
    address constant private VM_ADDRESS =
        address(bytes20(uint160(uint256(keccak256('hevm cheat code')))));
    Vm constant private vm = Vm(VM_ADDRESS);

    function resetEnv() internal {
        vm.setEnv("WHY_USE_THIS_KEY",               "");
        vm.setEnv("SOME_VERY_IMPORTANT_API_KEY",    "");
        vm.setEnv("A_COMPLEX_ENV_VARIABLE",         "");
        vm.setEnv("A_NUMBER",                       "");
        vm.setEnv("A_TRUE_BOOL",                    "");
        vm.setEnv("A_FALSE_BOOL",                   "");
        vm.setEnv("A_FALSE_BOOL",                   "");
        vm.setEnv("AN_ADDRESS",                     "");
        vm.setEnv("A_BYTES_32",                     "");
    }
}

contract SolenvTest is Test {
    function testEnv() public {
        // act
        Solenv.config();

        // assert
        assertEq(vm.envString("WHY_USE_THIS_KEY"),              "because we can can can");
        assertEq(vm.envString("SOME_VERY_IMPORTANT_API_KEY"),   "omgnoway");
        assertEq(vm.envString("A_COMPLEX_ENV_VARIABLE"),        "y&2U9xiEINv!vM8Gez");
        assertEq(vm.envUint("A_NUMBER"),                        100);
        assertEq(vm.envBool("A_TRUE_BOOL"),                     true);
        assertEq(vm.envBool("A_FALSE_BOOL"),                    false);
        assertEq(vm.envBool("A_FALSE_BOOL"),                    false);
        assertEq(vm.envAddress("AN_ADDRESS"), 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
        assertEq(vm.envBytes32("A_BYTES_32"), 0x0000000000000000000000000000000000000000000000000000000000000010);

        // cleanup
        SolenvHelper.resetEnv();
    }

    function testEnv_AnotherFilename() public {
        Solenv.config(".env.test");

        assertEq(vm.envString("SOME_VERY_IMPORTANT_API_KEY"), "adifferentone");

        SolenvHelper.resetEnv();
    }
}

contract SolenvMergeTest is Test {
    function testEnv_Merge() public {
        // arrange
        vm.setEnv("WHY_USE_THIS_KEY",   "different value");
        vm.setEnv("A_NUMBER",           "1337");
        vm.setEnv("A_TRUE_BOOL",        "false");
        vm.setEnv("A_FALSE_BOOL",       "true");

        // act
        Solenv.config(false);

        // assert
        // from file
        assertEq(vm.envString("SOME_VERY_IMPORTANT_API_KEY"),   "omgnoway");
        assertEq(vm.envString("A_COMPLEX_ENV_VARIABLE"),        "y&2U9xiEINv!vM8Gez");
        assertEq(vm.envAddress("AN_ADDRESS"), 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
        assertEq(vm.envBytes32("A_BYTES_32"), 0x0000000000000000000000000000000000000000000000000000000000000010);

        // set manually
        assertEq(vm.envString("WHY_USE_THIS_KEY"),  "different value");
        assertEq(vm.envUint("A_NUMBER"),            1337);
        assertEq(vm.envBool("A_TRUE_BOOL"),         false);
        assertEq(vm.envBool("A_FALSE_BOOL"),        true);

        // cleanup
        SolenvHelper.resetEnv();
    }
}

contract SolenvInSetupTest is Test {
    function setUp() public {
        // act
        Solenv.config();
    }

    function testEnv_InSetup() public {
        // assert
        assertEq(vm.envString("WHY_USE_THIS_KEY"),              "because we can can can");
        assertEq(vm.envString("SOME_VERY_IMPORTANT_API_KEY"),   "omgnoway");
        assertEq(vm.envString("A_COMPLEX_ENV_VARIABLE"),        "y&2U9xiEINv!vM8Gez");
        assertEq(vm.envUint("A_NUMBER"),                        100);
        assertEq(vm.envBool("A_TRUE_BOOL"),                     true);
        assertEq(vm.envBool("A_FALSE_BOOL"),                    false);
        assertEq(vm.envBool("A_FALSE_BOOL"),                    false);
        assertEq(vm.envAddress("AN_ADDRESS"), 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
        assertEq(vm.envBytes32("A_BYTES_32"), 0x0000000000000000000000000000000000000000000000000000000000000010);

        SolenvHelper.resetEnv();
    }
}
