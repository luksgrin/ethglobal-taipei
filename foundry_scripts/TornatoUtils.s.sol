// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";

contract TornadoUtils is Script {

    function withdraw(
        string memory note,
        string memory recipient
    ) public {
        vm.startBroadcast();
        string[] memory args = new string[](4);
        args[0] = "node";
        args[1] = "./scripts/withdraw_helper.js";
        args[2] = note;
        args[3] = recipient;

        bytes memory res = vm.ffi(args);
        console.logBytes(res);
        vm.stopBroadcast();
    }

    function run() public pure {
        revert("Run this script with flag `--sig run(address[],uint256[])` and provide ERC20 addresses and amounts");
    }
}
