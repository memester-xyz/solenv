// SPDX-License-Identifier: BSD-3-Clause

pragma solidity ^0.8.13;

/**
 * @author evmgolf
 * @dev String operations.
 * @author Based on OpenZeppelin (https://github.com/OpenZeppelin/openzeppelin-contracts/master/contracts/utils/String.sol)
 */
library Decimal {
    /**
     * @dev Converts a `uint256` to its ASCII `string` decimal representation.
     */
    function decimal(uint256 value) internal pure returns (bytes memory buffer) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol

        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
    }

    function decodeUint(bytes memory text) internal pure returns (uint value) {
      uint scale = 1;
      for (uint i=text.length-1;;i--) {
        value += (uint(uint8(text[i])) - 48) * scale;
        if (i == 0) {
          break;
        }
        scale *= 10;
      }
    }
}
