// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;
import {Vm} from "forge-std/Vm.sol";

library Solenv {
    Vm constant vm = Vm(address(bytes20(uint160(uint256(keccak256("hevm cheat code"))))));

    function config() public returns (bytes memory) {
        string[] memory inputs = new string[](3);
        inputs[0] = "sh";
        inputs[1] = "-c";
        inputs[2] = 'cast abi-encode "response(bytes)" $(xxd -p -c 1000000 .env)';

        bytes memory res = vm.ffi(inputs);
        return res;
    }
}
