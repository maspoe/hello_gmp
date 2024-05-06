// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IGmpReceiver} from "@analog-gmp/interfaces/IGmpReceiver.sol";
import {IGateway} from "@analog-gmp/interfaces/IGateway.sol";

contract Counter is IGmpReceiver {
    address private immutable _gateway;
    uint256 public number;

    constructor(address gateway) {
        _gateway = gateway;
    }

    function onGmpReceived(bytes32, uint128, bytes32, bytes calldata) external payable returns (bytes32) {
        require(msg.sender == _gateway, "unauthorized");
        number++;
        return bytes32(number);
    }

    import {GmpTestTools} from "@analog-gmp-testing/GmpTestTools.sol";

// Deploy gateway contracts and create forks for all supported networks
GmpTestTools.setup();

// Set `account` balance in all networks
GmpTestTools.deal(address(account), 100 ether);

// Switch to Sepolia network
GmpTestTools.switchNetwork(5);

// Switch to Shibuya network and set `account` as `msg.sender` and `tx.origin`
GmpTestTools.switchNetwork(7, address(account));

// Relay all pending GMP messages.
GmpTestTools.relayMessages();

}