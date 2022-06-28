// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import { Vm } from 'forge-std/Vm.sol'; 

library Solenv {
    Vm constant vm = Vm(address(bytes20(uint160(uint256(keccak256("hevm cheat code"))))));
    
    function invokeStuff() public returns (bytes memory) {
        string[] memory inputs = new string[](3);
        inputs[0] = "echo";
        inputs[1] = "-n";
        // ABI encoded "gm", as a string
        inputs[2] = "0x0000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000002a72616e646f6d3d62756c6c7368697420776f6f6c736869740a72616e646f6d323d62756c6c736869743200000000000000000000000000000000000000000000";

        bytes memory res = vm.ffi(inputs);
        return res;
    }
}
