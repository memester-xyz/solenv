# Bash - A simple module for executing bash scripts via foundry ffi

[![foundry-test](https://github.com/evmgolf/bash/actions/workflows/main.yml/badge.svg)](https://github.com/evmgolf/bash/actions/workflows/main.yml)

## Usage 
Every ffi call MUST return a hexadecimal encoded result (including empty) to be processed

eg. `echo`

```solidity
import "forge-std/Script.sol";
import {Decimal} from "codec/Decimal.sol";
import {Bash} from bash/Bash.sol";

contract Echo is Script {
  using Decimal for uint;
  event log(uint);

  function run() external {
    Bash bash = new Bash();
    uint data = 5;
    log(abi.decode(bash.run(bytes.concat("echo ", data.decimal(), "|cast --to-uint256"), ""), (uint)));
  }
}
```

eg. output to file 

```solidity
import "forge-std/Script.sol";
import {Decimal} from "codec/Decimal.sol";
import {Bash} from bash/Bash.sol";

contract Output is Script {
  using Decimal for uint;

  function run() external {
    Bash bash = new Bash();
    uint data = 5;
    bash.run(bytes.concat("echo ", data.decimal()), filename);
  }
}
```
