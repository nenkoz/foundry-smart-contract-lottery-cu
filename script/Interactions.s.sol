// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Raffle} from "../src/Raffle.sol";
import {HelperConfig, CodeConstants} from "./HelperConfig.s.sol";
import {console} from "forge-std/console.sol";
import {VRFCoordinatorV2Mock} from "@chainlink/contracts/src/v0.8/mocks/VRFCoordinatorV2Mock.sol";
import {Script} from "forge-std/Script.sol";
import {LinkToken} from "../test/mocks/LinkToken.sol";



contract CreateSubscription is Script {
    function createSubscriptionUsingConfig() public returns (uint256, address) {
        HelperConfig helperConfig = new HelperConfig();
        address vrfCoordinator = helperConfig.getConfig().vrfCoordinator;
        (uint256 subId,) = createSubscription(vrfCoordinator);
        return (subId, vrfCoordinator);
    }

    function createSubscription(address vrfCoordinator) public returns (uint256, address) {
        console.log("Creating subscription on chainId: ", block.chainid);
        vm.startBroadcast();
        uint256 subId = VRFCoordinatorV2Mock(vrfCoordinator).createSubscription();
        vm.stopBroadcast();
        console.log("Subscription ID: ", subId);
        console.log("Please update the subscription ID in the HelperConfig.s.sol file");
        return (subId, vrfCoordinator);
    }

    function run() public {
        createSubscriptionUsingConfig();
    }
}

// contract FundSubscription is Script, CodeConstants {
//     uint256 public constant FUND_AMOUNT = 3 ether;

//     function fundSubscriptionUsingConfig() public {
//         HelperConfig helperConfig = new HelperConfig();
//         address vrfCoordinator = helperConfig.getConfig().vrfCoordinator;
//         uint256 subscriptionId = helperConfig.getConfig().subscriptionId;
//         address linkToken = helperConfig.getConfig().linkToken;
//         fundSubscription(vrfCoordinator, subscriptionId, linkToken);
//     }

//     // function fundSubscription(address vrfCoordinator, uint256 subscriptionId, address linkToken) public {
//     //     console.log("Funding subscription: ", subscriptionId);
//     //     console.log("Using vrfCoordinator: ", vrfCoordinator);
//     //     console.log("On chainId: ", block.chainid);

//     //     // if(block.chainid == LOCAL_CHAIN_ID) {
//     //     // vm.startBroadcast();
//     //     // VRFCoordinatorV2Mock(vrfCoordinator).fundSubscription(subscriptionId, FUND_AMOUNT);
//     //     // LinkToken(linkToken).transferAndCall(vrfCoordinator, FUND_AMOUNT, abi.encode(subscriptionId));
//     //     //     vm.stopBroadcast();
//     //     // } else {
//     //     //     revert("Only local chain is supported");
//     //     // }
//     // }

//     // function run() public {}
// }