// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Vm} from "forge-std/Vm.sol";
import {strings} from "solidity-stringutils/strings.sol";

string constant DEFAULT_ENV_LOCATION = ".env";

library Solenv {
    using strings for *;

    Vm constant vm = Vm(address(bytes20(uint160(uint256(keccak256("hevm cheat code"))))));

    function _envExists(string memory key) private returns (bool) {
        try vm.envString(key) returns (string memory rEnv) {
            if (keccak256(abi.encodePacked(rEnv)) == keccak256("")) {
                return false;
            } else {
                return true;
            }
        } catch {
            return false;
        }
    }

    // todo: check if we can support setting delimiters
    function _config(string memory filename, bool overwrite) private returns (bool success) {
        string[] memory inputs = new string[](3);
        inputs[0] = "sh";
        inputs[1] = "-c";
        inputs[2] = string(
            bytes.concat('cast abi-encode "response(bytes)" $(xxd -p -c 0 ', bytes(filename), ")")
        );

        bytes memory res = vm.ffi(inputs);
        try vm.ffi(inputs) returns (bytes memory rRes) {
            res = rRes;
        } catch {
            // failed to load the env from file, we assume if the script needs
            // the env vars they will try to read them and subsequently error.
            // ergo, it is preferable to just return gracefully here
            return false;
        }

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
                    if (overwrite == true) {
                        vm.setEnv(key, line.toString());
                    } else {
                        if (_envExists(key)) {
                            // pre-existing found, do not overwrite
                        } else {
                            // pre-existing not found, insert
                            vm.setEnv(key, line.toString());
                        }
                    }
                }
            }
        }

        return true;
    }

    function config(string memory filename, bool overwrite) internal returns (bool success) {
        return _config(filename, overwrite);
    }

    function config(string memory filename) internal returns (bool success) {
        return config(filename, true);
    }

    function config(bool overwrite) internal returns (bool success) {
        return config(DEFAULT_ENV_LOCATION, overwrite);
    }

    function config() internal returns (bool success) {
        return config(DEFAULT_ENV_LOCATION);
    }
}
