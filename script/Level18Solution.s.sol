// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import {MagicNum} from "../src/Level18.sol";

contract Level18Sol is Script{
    MagicNum public magicNum = MagicNum(0xD5cf766bc937340767d9cf5Fd89eF1C14b78BF9B);
    function run() external{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Attack().exploit();
        vm.stopBroadcast();

    }
}
contract Attack{
    MagicNum public magicNum = MagicNum(0xD5cf766bc937340767d9cf5Fd89eF1C14b78BF9B);
    function exploit() public{
        bytes memory bytecode = hex"69602a60005260206000f3600052600a6016f3";
        address _solver;
          // create(value, offset, size)
        assembly{
            _solver:= create(0,add(bytecode,0x20),0x13)
        }
        require(_solver != address(0));
        magicNum.setSolver(_solver);
    }
}