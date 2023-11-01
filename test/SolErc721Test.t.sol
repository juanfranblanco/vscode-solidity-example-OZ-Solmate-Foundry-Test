// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {SolErc721} from "../src/SolErc721.sol";


contract SolErc721Test is Test {
    SolErc721 public solErc721;
    address internal alice = 0x12890D2cce102216644c59daE5baed380d84830c;

    function setUp() public {
        solErc721 = new SolErc721("SolErc721", "SOL");
        vm.label(alice, "Alice");
    }

    function test_mint() public {
        solErc721.mintTo(alice);
        assertEq(solErc721.balanceOf(alice), 1);
        assertEq(solErc721.ownerOf(1), alice);
        assertEq(solErc721.tokenURI(1), "1");
    }
}
