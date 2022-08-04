// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { GlobalState, state } from "../libraries/GlobalState.sol";
import { OpenEditionLibrary } from "../libraries/OpenEditionLibrary.sol";

contract OpenEditionFacet {
    /**
     * @dev Begin the sale. The sale period
     * will automatically elapse and conclude. 
     */
    function beginSale() public {
        GlobalState.requireCallerIsAdmin();
        OpenEditionLibrary.getState().saleTimestamp = block.timestamp;
    }

    /**
     * @dev Set the exact time when the sale will begin.
     */
    function setSaleTimestamp(uint256 timestamp) public {
        GlobalState.requireCallerIsAdmin();
        OpenEditionLibrary.getState().saleTimestamp = timestamp;
    }

    /**
     * @dev Set the sale length in seconds.
     */
    function setSaleLength(uint256 length) public {
        GlobalState.requireCallerIsAdmin();
        OpenEditionLibrary.getState().saleLength = length;
    }

    /**
     * @dev Set the sale length in hours.
     */
    function setSaleLengthInHours(uint256 length) public {
        GlobalState.requireCallerIsAdmin();
        OpenEditionLibrary.getState().saleLength = length * 3600;
    }

    /**
     * @dev Check whether the sale is currently active.
     */
    function isSaleActive() public view returns (bool) {
        return OpenEditionLibrary.isSaleActive();
    }
}