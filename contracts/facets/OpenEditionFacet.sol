// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { GlobalState } from "../libraries/GlobalState.sol";
import { OpenEditionLib } from "../libraries/OpenEditionLib.sol";

contract OpenEditionFacet {
    /**
     * @dev Begin the sale. The sale period
     * will automatically elapse and conclude. 
     */
    function beginSale() public {
        GlobalState.requireCallerIsAdmin();
        OpenEditionLib.getState().saleTimestamp = block.timestamp;
    }

    /**
     * @dev Set the exact time when the sale will begin.
     */
    function setSaleTimestamp(uint256 timestamp) public {
        GlobalState.requireCallerIsAdmin();
        OpenEditionLib.getState().saleTimestamp = timestamp;
    }

    /**
     * @dev Set the sale length in seconds.
     */
    function setSaleLength(uint256 length) public {
        GlobalState.requireCallerIsAdmin();
        OpenEditionLib.getState().saleLength = length;
    }

    /**
     * @dev Set the sale length in hours.
     */
    function setSaleLengthInHours(uint256 length) public {
        GlobalState.requireCallerIsAdmin();
        OpenEditionLib.getState().saleLength = length * 3600;
    }

    /**
     * @dev Check whether the sale is currently active.
     */
    function isSaleActive() public view returns (bool) {
        return OpenEditionLib.isSaleActive();
    }
}