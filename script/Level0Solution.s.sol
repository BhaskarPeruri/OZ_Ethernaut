// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level0.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Level0Sol is Script{
    
    Instance public level0 = Instance(0x45788399AFea13881872eA360A071f86E3D946fb);//pass the contract address deployed on the sepolia testnet
    function run() external{
        
        string memory password = level0.password();
        console.log("Password:",password);
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));//this will broadcast the transaction to the sepolia blockchain
        level0.authenticate(password);
        vm.stopBroadcast();
    }
}