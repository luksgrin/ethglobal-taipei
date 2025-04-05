// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {DeployMiMCSponge} from "../foundry_scripts/MiMCSponge.s.sol";
import {IHasher} from "../contracts/MerkleTreeWithHistory.sol";

contract MiMCSpongeTest is Test, DeployMiMCSponge {
    uint256 public constant FIELD_SIZE = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
    uint256 public constant ZERO_VALUE = 21663839004416932945382355908790599225266501822907911457504978515578255421292; // = keccak256("tornado") % FIELD_SIZE
    IHasher public mimcSponge;

    function setUp() public {
        mimcSponge = IHasher(deployMimcSponge());
    }

    /**
     * @notice This test checks that the deployed contract is not zero.
     * @dev The deployed contract is the result of the deployMimcSponge function.
     */
    function testDeployment() external view {
        // Check that the deployed address is not zero.
        assertGt(address(mimcSponge).code.length, 0, "Deployed contract's bytecode length is zero");
    }

    /**
     * @notice This test checks that the hash of the input value is equal to the expected value.
     * @dev The input value is the hash of the string "tornado" modulo FIELD_SIZE.
     * @dev The expected value is the hash of the string "tornado" modulo FIELD_SIZE.
     * @dev The hash function is MiMCSponge.
     * @dev The reference value is taken from the MerkleTreeWithHistory contract; which has that value hardcoded.
     */
    function testMiMCSponge() external view {
        uint256 R = uint256(ZERO_VALUE);
        uint256 C = 0;
        (R, C) = mimcSponge.MiMCSponge(R, C);
        R = addmod(R, uint256(ZERO_VALUE), FIELD_SIZE);
        (R, C) = mimcSponge.MiMCSponge(R, C);
        assertEq(
            bytes32(R),
            bytes32(0x256a6135777eee2fd26f54b8b7037a25439d5235caee224154186d2b8a52e31d),
            "Hash of 'keccak256(\"tornado\") % FIELD_SIZE' is not equal to the expected value."
        );
    }
}
