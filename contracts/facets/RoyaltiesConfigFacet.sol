// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { GlobalState } from "../libraries/GlobalState.sol";
import { RoyaltiesConfigLib } from "../libraries/RoyaltiesConfigLib.sol";

contract RoyaltiesConfigFacet {
    /**
     * @dev Check whether the sale is currently active.
     */
    function royaltyInfo(uint256, uint256 value) external virtual view returns (address, uint256) {
        return RoyaltiesConfigLib.royaltyInfo(0, value);
    }

    /**
    * @dev Set royalty recipient and basis points.
     */
    function setRoyalties(address payable recipient, uint256 bps) public {
        GlobalState.requireCallerIsAdmin();

        RoyaltiesConfigLib.state storage s = RoyaltiesConfigLib.getState();
        s.royaltyRecipient = recipient;
        s.royaltyBps = bps;
    }
}