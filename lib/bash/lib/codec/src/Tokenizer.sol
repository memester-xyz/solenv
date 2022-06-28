// SPDX-License-Identifier: BSD-3-Clause

pragma solidity ^0.8.13;

/**
 * @author evmgolf
 * @dev Byte string tokenizer
 */
library Tokenizer {
    function count(bytes memory text, bytes memory substring) internal pure returns (uint result) {
      uint j;
      for (uint i=0; i<text.length; i++) {
        if (text[i] == substring[j]) {
          j++;
          if (j == substring.length) {
            result++;
            j = 0;
          }
        } else {
          j = 0;
        }
      }
    }

    /**
     * @dev Splits the byte string on the delimiter
     */
    function split(bytes memory text, bytes memory delimiter) internal pure returns (bytes[] memory results) {
      results = new bytes[](count(text, delimiter) + 1);
      uint j;
      uint index;

      for (uint i=0; i<text.length; i++) {
        if (text[i] == delimiter[j]) {
          j++;
          if (j == delimiter.length) {
            index++;
            j = 0;
          }
        } else {
          results[index] = bytes.concat(results[index], text[i]);
          j = 0;
        }
      }
    }
}
