// SPDX-License-Identifier: MIT
pragma solidity ^0.8.29;

contract BadRecipient {
  fallback() external {
    require(false, "this contract does not accept ETH");
  }
}
