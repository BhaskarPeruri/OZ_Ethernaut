// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level0.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Level0 is Script{
    
    Level0 public level0 = Level0(0x45788399AFea13881872eA360A071f86E3D946fb);
    function run() external{
        
        string memory password = level0.password();
        console.log("Password:",password);
        vm.startBroadcast(vm.envUint("PRVATE-KEY"));
        level0.authenticate(password);
        vm.stopBroadcast();
    }
}