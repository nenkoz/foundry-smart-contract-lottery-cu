// Layout of Contract:
// version
// imports
// errors
// interfaces, libraries, contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of Functions:
// constructor
// receive function (if exists)
// fallback function (if exists)
// external
// public
// internal
// private
// view & pure functions

//SPDX-License-Identifier: MIT

pragma solidity 0.8.19;



/**
 * @title Raffle contract
 * @author @nenkoz
 * @notice This contract is for creating a sample raffle
 * @dev Implements Chainlink VRF and Chainlink Keepers
 */
contract Raffle {
    /* Errors */
    error Raffle__SendMoreToEnterRaffle();
    error Raffle__TooEarly();

    /* State variables */
    uint256 private immutable i_entranceFee;
    // @dev interval between raffle picks
    uint256 private immutable i_interval;
    address payable[] private s_players;
    uint256 private s_lastTimeStamp;

    /* Events */
    event RaffleEntered(address indexed player);

    /* Constructor */
    constructor(uint256 entranceFee, uint256 interval) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
    }

    function enterRaffle() external payable {
        // require(msg.value >= i_entranceFee, "Must send at least entrance fee");
        if(msg.value < i_entranceFee) {
            revert Raffle__SendMoreToEnterRaffle();
        }
        s_players.push(payable(msg.sender));
        emit RaffleEntered(msg.sender);
    }

    function pickWinner() external view {
        if(block.timestamp - s_lastTimeStamp < i_interval) {
            revert Raffle__TooEarly ();
        }
    }

    /** Getter Functions */
    function getEntranceFee() external view returns (uint256) {
        return i_entranceFee;
    }
}
