# <h1 align="center"> Solenv </h1>

**Load .env files in Solidity scripts/tests**

![Github Actions](https://github.com/memester-xyz/solenv/workflows/test/badge.svg)

## Installation

```
forge install memester-xyz/solenv
```

## Usage

Firstly, it's very important that you do not commit your `.env` file. It should go without saying but make sure to add it to your `.gitignore` file! This repo has committed the `.env` and `.env.test` files only for examples and tests.

1. Add this import to your script or test:
```solidity
import {Solenv} from "solenv/Solenv.sol";
```

2. Call `.config()` somewhere. It defaults to using `.env` in your project root, but you can pass another string as a parameter to load another file in instead.
```solidity
// Inside a test
function setUp() public {
    Solenv.config();
}

// Inside a script, load a file with a different name
function run() public {
    Solenv.config(".env.prod");

    // Continue with your script...
}
```

3. You can then use the [standard "env" cheatcodes](https://book.getfoundry.sh/cheatcodes/external.html) in order to read your variables. e.g. `envString`, `envUint`, `envBool`, etc.
```solidity
string memory apiKey = vm.envString("API_KEY");
uint256 retries = vm.envUint("RETRIES");
bool ouputLogs = vm.envBool("OUTPUT_LOGS");
```

## Example

[Check out the test to see how to use this library.](./test/Solenv.t.sol)

## Contributing

Clone this repo and run:

```
forge install
```

Make sure all tests pass, add new ones if needed:

```
forge test
```

## Why?

[Forge scripting](https://book.getfoundry.sh/tutorials/solidity-scripting.html) is becoming more popular. With Solenv your scripts are even more powerful and natural to work with.

## Development

This project uses [Foundry](https://getfoundry.sh). See the [book](https://book.getfoundry.sh/getting-started/installation.html) for instructions on how to install and use Foundry.
