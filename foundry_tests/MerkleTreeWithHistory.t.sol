// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {DeployMiMCSponge} from "../foundry_scripts/MiMCSponge.s.sol";
import {DeployMerkleTreeWithHistory} from "../foundry_scripts/MerkleTreeWithHistory.s.sol";

import {IHasher} from "../contracts/MerkleTreeWithHistory.sol";
import {IHasher, MerkleTreeWithHistoryMock} from "../contracts/Mocks/MerkleTreeWithHistoryMock.sol";

contract MiMCSpongeTest is Test, DeployMerkleTreeWithHistory, DeployMiMCSponge {
    IHasher public mimcSponge;
    MerkleTreeWithHistoryMock public merkleTreeWithHistory;

    function setUp() public {
        mimcSponge = IHasher(deployMimcSponge());
        merkleTreeWithHistory = deployMerkleTreeMock(20, mimcSponge);
    }

    /**
     * @notice This test checks that the deployed contract has nonzero bytecode.
     * @dev The deployed contract is the result of the deployMerkleTree function.
     */
    function testDeployment() external view {
        assertGt(address(merkleTreeWithHistory).code.length, 0, "Deployed contract's bytecode length is zero");
    }

    /**
     * @notice This test checks that the constructor initializes the tree correctly.
     * @dev The constructor initializes the tree with the correct values.
     */
    function testConstructorInitialization() external view {
        uint256 zeroValue = merkleTreeWithHistory.ZERO_VALUE();

        uint256 firstSubtree = uint256(merkleTreeWithHistory.filledSubtrees(0));
        assertEq(firstSubtree, zeroValue, "First subtree mismatch");

        uint256 firstZero = uint256(merkleTreeWithHistory.zeros(0));
        assertEq(firstZero, zeroValue, "First zero mismatch");
    }

    /**
     * @notice This test checks that the tree rejects if it is full.
     * @dev The tree rejects if it is full.
     */
    function testRejectIfTreeFull() external {
        uint32 levels = 6; // For example
        MerkleTreeWithHistoryMock smallMerkleTree = deployMerkleTreeMock(levels, mimcSponge);

        for (uint256 i = 0; i < 2 ** levels; i++) {
            smallMerkleTree.insert(bytes32(i + 42));
        }

        vm.expectRevert(bytes("Merkle tree is full. No more leaves can be added"));
        smallMerkleTree.insert(bytes32(uint256(1337)));

        vm.expectRevert(bytes("Merkle tree is full. No more leaves can be added"));
        smallMerkleTree.insert(bytes32(uint256(1)));
    }

    /**
     * @notice This test checks that the tree does not return uninitialized roots.
     * @dev The tree does not return uninitialized roots.
     */
    function testNotReturnUninitializedRoots() external {
        merkleTreeWithHistory.insert(bytes32(uint256(42)));
        bool isKnown = merkleTreeWithHistory.isKnownRoot(bytes32(uint256(0)));
        assertFalse(isKnown, "Uninitialized root incorrectly recognized as known");
    }
}
