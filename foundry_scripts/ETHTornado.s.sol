// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";

import {IVerifier} from "../contracts/Tornado.sol";
import {ETHTornado} from "../contracts/ETHTornado.sol";
import {IHasher} from "../contracts/MerkleTreeWithHistory.sol";

contract DeployETHTornado is Script {
    /// @notice Deploys a new ETHTornado contract.
    /// @param _verifier Address of the verifier contract.
    /// @param _hasher Address of the hasher contract.
    /// @param _denomination Denomination of the ETHTornado.
    /// @param _merkleTreeHeight Height of the Merkle tree.
    /// @return deployed Instance of the deployed ETHTornado.
    function deployETHTornado(IVerifier _verifier, IHasher _hasher, uint256 _denomination, uint32 _merkleTreeHeight)
        internal
        returns (ETHTornado deployed)
    {
        deployed = new ETHTornado({
            _verifier: _verifier,
            _hasher: _hasher,
            _denomination: _denomination,
            _merkleTreeHeight: _merkleTreeHeight
        });
    }
}
