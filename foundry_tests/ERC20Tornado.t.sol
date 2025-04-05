// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.29;

import {Test} from "forge-std/Test.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {DeployVerifier} from "../foundry_scripts/Verifier.s.sol";
import {DeployERC20Tornado} from "../foundry_scripts/ERC20Tornado.s.sol";
import {DeployMiMCSponge} from "../foundry_scripts/MiMCSponge.s.sol";

import {ERC20Tornado} from "../contracts/ERC20Tornado.sol";

import {IVerifier} from "../contracts/Tornado.sol";
import {IHasher} from "../contracts/MerkleTreeWithHistory.sol";

contract ERC20TornadoTest is Test, DeployVerifier, DeployERC20Tornado, DeployMiMCSponge {
    ERC20Tornado erc20Tornado;
    IVerifier verifier;
    IHasher hasher;

    function setUp() public {
        verifier = IVerifier(address(deployVerifier()));
        hasher = IHasher(deployMimcSponge());
    }

    /**
     * @notice Used to test that the setup is working.
     */
    function test_deploy() public {
        address erc20Address = 0x6B175474E89094C44Da98b954EedeAC495271d0F; // DAI address

        erc20Tornado = deployERC20Tornado(
            verifier,
            hasher,
            1 ether,
            20, // Tree depth, which implies 2^20 = 1048576 leaves
            IERC20(erc20Address)
        );
    }

    /**
     * @notice Does not do anything, just to satisfy the override requirements.
     */
    function run() public override(DeployMiMCSponge, DeployVerifier) {}
}
