// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

import "../MerkleTreeWithHistory.sol";

contract MerkleTreeWithHistoryMock is MerkleTreeWithHistory {
  constructor(uint32 _treeLevels, IHasher _hasher) MerkleTreeWithHistory(_treeLevels, _hasher) {}

  function insert(bytes32 _leaf) public {
    _insert(_leaf);
  }
}
