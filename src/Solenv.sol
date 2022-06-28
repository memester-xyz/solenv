// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import { Vm } from 'forge-std/Vm.sol'; 

library Solenv {
    Vm constant vm = Vm(address(bytes20(uint160(uint256(keccak256("hevm cheat code"))))));
    
    function invokeStuff() public returns (bytes memory) {
        string[] memory inputs = new string[](3);
        inputs[0] = "ls";
        inputs[1] = "-lat";
        inputs[2] = "/etc";

        bytes memory res = vm.ffi(inputs);
        return res;
    }
}
