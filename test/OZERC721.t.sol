// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {OZErc721} from "../src/OZErc721.sol";


contract OZErc721Test is Test {
    OZErc721 public ozErc721;
    address internal alice = 0x12890D2cce102216644c59daE5baed380d84830c;

    function setUp() public {
        ozErc721 = new OZErc721(address(this));
        vm.label(alice, "Alice");
    }

    function test_mint() public {
        ozErc721.safeMint(alice, "https://example.com");
        assertEq(ozErc721.balanceOf(alice), 1);
        assertEq(ozErc721.ownerOf(0), alice);
        assertEq(ozErc721.tokenURI(0), "https://example.com");
    }

    function testBurn() public {
        ozErc721.safeMint(alice, "https://example.com");
        assertEq(ozErc721.balanceOf(alice), 1);
        vm.prank(alice);
        ozErc721.burn(0);
        assertEq(ozErc721.balanceOf(alice), 0);
    }
}
