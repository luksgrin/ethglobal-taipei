// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Verifier} from "../contracts/Verifier.sol";

contract DeployVerifier is Script {
    /// @notice Deploys a new Verifier contract.
    /// @return deployed Instance of the deployed Verifier.
    function deployVerifier()
        internal
        returns (Verifier deployed)
    {
        deployed = new Verifier();
    }

    function run() virtual public {
        Verifier verifier = deployVerifier();
        console.log("Verifier deployed at", address(verifier));
    }
}
