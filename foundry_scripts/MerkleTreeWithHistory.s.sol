// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {MerkleTreeWithHistory, IHasher} from "../contracts/MerkleTreeWithHistory.sol";
import {MerkleTreeWithHistoryMock} from "../contracts/Mocks/MerkleTreeWithHistoryMock.sol";

contract DeployMerkleTreeWithHistory is Script {
    /// @notice Deploys a new MerkleTreeWithHistory contract.
    /// @param _levels Number of levels for the Merkle tree.
    /// @param _hasher Address of the hasher contract.
    /// @return deployed Instance of the deployed MerkleTreeWithHistory.
    function deployMerkleTree(uint32 _levels, IHasher _hasher)
        internal
        returns (MerkleTreeWithHistory deployed)
    {
        deployed = new MerkleTreeWithHistory({
            _levels: _levels,
            _hasher: _hasher
        });
    }
    function deployMerkleTreeMock(uint32 _levels, IHasher _hasher)
        internal
        returns (MerkleTreeWithHistoryMock deployed)
    {
        deployed = new MerkleTreeWithHistoryMock({
            _treeLevels: _levels,
            _hasher: _hasher
        });
    }
}
