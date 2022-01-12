// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import {stdCheats} from "../stdlib.sol";
import "../Vm.sol";

contract StdCheatsTest is DSTest, stdCheats {
    Vm public constant vm = Vm(HEVM_ADDRESS);

    Bar test;
    function setUp() public {
        test = new Bar();
    }

    function testHoax() public {
        hoax(address(1337));
        test.bar{value: 100}(address(1337));
    }

    function testStartHoax() public {
        startHoax(address(1337));
        test.bar{value: 100}(address(1337));
        test.bar{value: 100}(address(1337));
        vm.stopPrank();
        test.bar(address(this));
    }
}

contract Bar {
    function bar(address expectedSender) public payable {
        require(msg.sender == expectedSender, "!prank");
    }
}