// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {console} from "forge-std/console.sol";
import "src/Solenv.sol";

contract ContractTest is Test {

    function setUp() public {}

    function testExample() public {
        bytes memory result = Solenv.invokeStuff();
        string memory data = abi.decode(result, (string));
        console.log(data);
    }
}
