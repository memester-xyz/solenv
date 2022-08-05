// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Vm} from "forge-std/Vm.sol";
import {strings} from "solidity-stringutils/strings.sol";

library Solenv {
    using strings for *;

    Vm constant vm = Vm(address(bytes20(uint160(uint256(keccak256("hevm cheat code"))))));

    function config(string memory filename) internal {
        string[] memory inputs = new string[](3);
        inputs[0] = "sh";
        inputs[1] = "-c";
        inputs[2] = string(
            bytes.concat(
                'cast abi-encode "response(bool)" $(test -f ',
                bytes(filename),
                ' && echo "true" || echo "false")'
            )
        );
        bytes memory res = vm.ffi(inputs);

        bool exists = abi.decode(res, (bool));

        if (exists) {
            inputs[0] = "sh";
            inputs[1] = "-c";
            inputs[2] = string(
                bytes.concat('cast abi-encode "response(bytes)" $(xxd -p -c 1000000 ', bytes(filename), ")")
            );

            res = vm.ffi(inputs);

            strings.slice memory data = abi.decode(res, (string)).toSlice();

            strings.slice memory lineDelim = "\n".toSlice();
            strings.slice memory keyDelim = "=".toSlice();
            strings.slice memory commentDelim = "#".toSlice();

            uint256 length = data.count(lineDelim) + 1;
            for (uint256 i = 0; i < length; i++) {
                strings.slice memory line = data.split(lineDelim);
                if (!line.startsWith(commentDelim)) {
                    string memory key = line.split(keyDelim).toString();
                    // Ignore empty lines
                    if (bytes(key).length != 0) {
                        vm.setEnv(key, line.toString());
                    }
                }
            }
        }
    }

    function config() internal {
        config(".env");
    }
}
