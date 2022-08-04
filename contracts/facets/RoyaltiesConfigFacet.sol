// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { GlobalState, state } from "../libraries/GlobalState.sol";
import { RoyaltiesConfigLibrary } from "../libraries/RoyaltiesConfigLibrary.sol";

contract RoyaltiesConfigFacet {
    /**
     * @dev Check whether the sale is currently active.
     */
    function royaltyInfo(uint256, uint256 value) external virtual view returns (address, uint256) {
        return RoyaltiesConfigLibrary.royaltyInfo(0, value);
    }

    /**
    * @dev Set royalty recipient and basis points.
     */
    function setRoyalties(address payable recipient, uint256 bps) public {
        GlobalState.requireCallerIsAdmin();

        GlobalState.state storage s = RoyaltiesConfigLibrary.getState();
        s.royaltyRecipient = recipient;
        s.royaltyBps = bps;
    }
}