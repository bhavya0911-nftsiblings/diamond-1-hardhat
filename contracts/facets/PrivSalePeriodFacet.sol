// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { GlobalState, state } from "../libraries/GlobalState.sol";
import { PrivSalePeriodLibrary } from "../libraries/PrivSalePeriodLibrary.sol";

contract PrivSalePeriodFacet {
    /**
    * @dev Get length of private sale in seconds.
    */
    function privSaleLength() public view returns (uint256) {
        return PrivSalePeriodLibrary.getState().privSaleLength;
    }

    /**
    * @dev Get timestamp when sale begins.
    */
    function saleTimestamp() public view returns (uint256) {
        return PrivSalePeriodLibrary.getState().saleTimestamp;
    }

    /**
     * @dev Begin the sale. The sale period will automatically
     *      elapse and conclude.
     */
    function beginPrivSale() public {
        GlobalState.requireCallerIsAdmin();
        PrivSalePeriodLibrary.getState().saleTimestamp = block.timestamp;
    }

    /**
     * @dev Set the exact time when the private sale will begin.
     */
    function setSaleTimestamp(uint256 timestamp) public {
        GlobalState.requireCallerIsAdmin();
        PrivSalePeriodLibrary.getState().saleTimestamp = timestamp;
    }

    /**
    * @dev Updates private sale length. Length argument must be
    *      a whole number of hours.
    */
    function setPrivSaleLengthInHours(uint256 length) public {
        GlobalState.requireCallerIsAdmin();
        PrivSalePeriodLibrary.getState().privSaleLength = length * 3600;
    }

    /**
    * @dev Returns a boolean indicating whether the private sale
    *      phase is currently active.
    */
    function isPrivSaleActive() public view returns (bool) {
        return PrivSalePeriodLibrary.isPrivSaleActive();
    }

    /**
    * @dev Returns whether the public sale is currently
    *      active.
    */
    function isPublicSaleActive() public view returns (bool) {
        return PrivSalePeriodLibrary.isPublicSaleActive();
    }
}