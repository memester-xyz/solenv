// SPDX-License-Identifier: BSD-3-Clause

pragma solidity ^0.8.13;

/**
 * @author evmgolf
 * @dev String operations.
 * @author Based on OpenZeppelin (https://github.com/OpenZeppelin/openzeppelin-contracts/master/contracts/utils/String.sol)
 */
library Hexadecimal {
    bytes16 private constant _HEX_SYMBOLS = "0123456789abcdef";
    uint8 private constant _ADDRESS_LENGTH = 20;

    function hexadecimal(bytes memory text) internal pure returns (bytes memory buffer) {
      buffer = new bytes(2 * (text.length + 1));
      buffer[0] = "0";
      buffer[1] = "x";
      for (uint i=0;i<text.length;i++) {
        uint value = uint(uint8(text[i]));
        uint bufferIndex = (i+1)*2;
        buffer[bufferIndex] = _HEX_SYMBOLS[(value >> 4) & 0xf];
        buffer[bufferIndex + 1] = _HEX_SYMBOLS[value & 0xf];
      }
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation.
     */
    function hexadecimal(uint256 value) internal pure returns (bytes memory) {
        if (value == 0) {
            return "0x00";
        }
        uint256 temp = value;
        uint256 length = 0;
        while (temp != 0) {
            length++;
            temp >>= 8;
        }
        return hexadecimal(value, length);
    }

    /**
     * @dev Converts a `uint256` to its ASCII `string` hexadecimal representation with fixed length.
     */
    function hexadecimal(uint256 value, uint256 length) internal pure returns (bytes memory buffer) {
        buffer = new bytes(2 * length + 2);
        buffer[0] = "0";
        buffer[1] = "x";
        for (uint256 i = 2 * length + 1; i > 1; --i) {
            buffer[i] = _HEX_SYMBOLS[value & 0xf];
            value >>= 4;
        }
        require(value == 0, "Hexadecimal:ZERO_LENGTH");
        return buffer;
    }

    /**
     * @dev Converts an `address` with fixed length of 20 bytes to its not checksummed ASCII `string` hexadecimal representation.
     */
    function hexadecimal(address addr) internal pure returns (bytes memory) {
        return hexadecimal(uint256(uint160(addr)), _ADDRESS_LENGTH);
    }

    function hexOffset(bytes1 b) internal pure returns (uint8) {
      uint8 d = uint8(b);
      if (d < 58) {
        return d - 48;
      } else if (d < 71) {
        return d - 55;
      } else {
        return d - 87;
      }
    }

    function decodeBytes(bytes memory text) internal pure returns (bytes memory buffer) {
      buffer = new bytes((text.length - 1) / 2);
      uint j;
      for (uint i=2; i<text.length;) {
        bytes1 upper = text[i++];
        bytes1 lower = text[i++];

        buffer[j++] = bytes1(
          uint8(
            (hexOffset(upper) << 4)
            + hexOffset(lower)
          )
        );
      }
    }

    function decodeAddress(bytes memory text) internal pure returns (address) {
      bytes memory nullPad = new bytes(12);
      return abi.decode(
        bytes.concat(
          nullPad,
          decodeBytes(text)
        ),
        (address)
      );
    }

    function isHexadecimal(bytes memory text) internal pure returns (bool) {
      return text.length >=2 && text[1] == "x";
    }
}
