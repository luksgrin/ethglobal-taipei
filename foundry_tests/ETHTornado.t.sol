// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.29;

import {Test} from "forge-std/Test.sol";

import {DeployVerifier} from "../foundry_scripts/Verifier.s.sol";
import {DeployETHTornado} from "../foundry_scripts/ETHTornado.s.sol";
import {DeployMiMCSponge} from "../foundry_scripts/MiMCSponge.s.sol";

import {ETHTornado} from "../contracts/ETHTornado.sol";

import {IVerifier} from "../contracts/Tornado.sol";
import {IHasher} from "../contracts/MerkleTreeWithHistory.sol";

contract ERC20TornadoTest is Test, DeployVerifier, DeployETHTornado, DeployMiMCSponge {
    ETHTornado tornado;

    function setUp() public {
        tornado = deployETHTornado(
            IVerifier(address(deployVerifier())),
            IHasher(deployMimcSponge()),
            1 ether,
            20 // Tree depth, which implies 2^20 = 1048576 leaves
        );
    }

    /**
     * @notice Used to test that the setup is working.
     */
    function test_deploy() public {}

    /**
     * @notice Does not do anything, just to satisfy the override requirements.
     */
    function run() public override(DeployMiMCSponge, DeployVerifier) {}
}
