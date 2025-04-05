// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

import {IVerifier} from "../contracts/Tornado.sol";
import {ERC20Tornado} from "../contracts/ERC20Tornado.sol";
import {IHasher} from "../contracts/MerkleTreeWithHistory.sol";

contract DeployERC20Tornado is Script {
    /// @notice Deploys a new ETHTornado contract.
    /// @param _verifier Address of the verifier contract.
    /// @param _hasher Address of the hasher contract.
    /// @param _denomination Denomination of the ETHTornado.
    /// @param _merkleTreeHeight Height of the Merkle tree.
    /// @return deployed Instance of the deployed ETHTornado.
    function deployERC20Tornado(
        IVerifier _verifier,
        IHasher _hasher,
        uint256 _denomination,
        uint32 _merkleTreeHeight,
        IERC20 _token
    ) internal returns (ERC20Tornado deployed) {
        deployed = new ERC20Tornado({
            _verifier: _verifier,
            _hasher: _hasher,
            _denomination: _denomination,
            _merkleTreeHeight: _merkleTreeHeight,
            _token: _token
        });
    }
}
