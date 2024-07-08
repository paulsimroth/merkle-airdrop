// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {MerkleAirdrop} from "../src/MerkleAirdrop.sol";
import {Token} from "../src/Token.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract DeployMerkleAirdrop is Script {
    bytes32 private s_merkleRoot = 0xaa5d581231e596618465a56aa0f5870ba6e20785fe436d5bfb82b08662ccc7c4;
    uint256 private s_airdropAmount = 4 * 25 * 1e18;

    function run() external returns (MerkleAirdrop, Token) {
        return deployAirdrop();
    }

    function deployAirdrop() public returns (MerkleAirdrop, Token) {
        vm.startBroadcast();
        Token token = new Token();
        MerkleAirdrop airdrop = new MerkleAirdrop(s_merkleRoot, IERC20(address(token)));
        token.mint(token.owner(), s_airdropAmount);
        token.transfer(address(airdrop), s_airdropAmount);
        vm.stopBroadcast();
        return (airdrop, token);
    }
}
