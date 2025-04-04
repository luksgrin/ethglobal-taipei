// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {IVerifier} from "../contracts/Tornado.sol";
import {IHasher} from "../contracts/MerkleTreeWithHistory.sol";

import {Verifier} from "../contracts/Verifier.sol";
import {ETHTornado} from "../contracts/ETHTornado.sol";
import {ERC20Tornado} from "../contracts/ERC20Tornado.sol";

import {DeployVerifier} from "./Verifier.s.sol";
import {DeployMiMCSponge} from "./MiMCSponge.s.sol";
import {DeployETHTornado} from "./ETHTornado.s.sol";
import {DeployERC20Tornado} from "./ERC20Tornado.s.sol";

contract DeployProject is Script, DeployETHTornado, DeployERC20Tornado, DeployVerifier, DeployMiMCSponge {

    function run() public pure override(DeployVerifier, DeployMiMCSponge) {
        revert("Run this script with flag `--sig run(address[],uint256[])` and provide ERC20 addresses and amounts");
    }
    function run(
        address[] calldata erc20Addresses, // ERC20 addresses to deploy Tornados for
        uint256[] calldata amounts // Amounts to deploy Tornados for
    ) public {
        vm.startBroadcast();

        IVerifier verifier = IVerifier(address(deployVerifier()));
        IHasher hasher = IHasher(deployMimcSponge());

        console.log("-> Verifier deployed at %s", address(verifier));
        console.log("-> Hasher deployed at %s", address(hasher));

        ETHTornado _tornado;
        ERC20Tornado _erc20Tornado;

        // Deploy 4 Tornados with 0.1, 1, 10, 100 ETH
        for (uint8 i; i < 4; i++) {
            _tornado = deployETHTornado(
                IVerifier(address(verifier)),
                IHasher(address(hasher)),
                (0.1 ether) * (10 ** i),
                20
            );
            console.log(
                "-> Tornado %s * 0.1 ETH deployed at: %s",
                (10 ** i),
                address(_tornado)
            );
        }

        // Deploy tornados for ERC20s
        uint256 len = erc20Addresses.length;

        require(
            len == amounts.length,
            "ERC20 addresses and amounts must have the same length"
        );

        for (uint256 i; i < len; i++) {
            uint256 amount = amounts[i];
            address erc20Address = erc20Addresses[i];
            _erc20Tornado = deployERC20Tornado(
                IVerifier(address(verifier)),
                IHasher(address(hasher)),
                amount,
                20,
                IERC20(erc20Address)
            );
            console.log(
                "-> Tornado with denomination of %s for ERC20 address %s deployed at %s",
                amount,
                erc20Address,
                address(_erc20Tornado)
            );
        }
        vm.stopBroadcast();
    }
}
