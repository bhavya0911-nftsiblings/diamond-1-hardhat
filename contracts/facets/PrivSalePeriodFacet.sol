// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { GlobalState } from "../libraries/GlobalState.sol";
import { PrivSalePeriodLib } from "../libraries/PrivSalePeriodLib.sol";

contract PrivSalePeriodFacet {
    /**
    * @dev Get length of private sale in seconds.
    */
    function privSaleLength() public view returns (uint256) {
        return PrivSalePeriodLib.getState().privSaleLength;
    }

    /**
    * @dev Get timestamp when sale begins.
    */
    function saleTimestamp() public view returns (uint256) {
        return PrivSalePeriodLib.getState().saleTimestamp;
    }

    /**
     * @dev Begin the sale. The sale period will automatically
     *      elapse and conclude.
     */
    function beginPrivSale() public {
        GlobalState.requireCallerIsAdmin();
        PrivSalePeriodLib.getState().saleTimestamp = block.timestamp;
    }

    /**
     * @dev Set the exact time when the private sale will begin.
     */
    function setSaleTimestamp(uint256 timestamp) public {
        GlobalState.requireCallerIsAdmin();
        PrivSalePeriodLib.getState().saleTimestamp = timestamp;
    }

    /**
    * @dev Updates private sale length. Length argument must be
    *      a whole number of hours.
    */
    function setPrivSaleLengthInHours(uint256 length) public {
        GlobalState.requireCallerIsAdmin();
        PrivSalePeriodLib.getState().privSaleLength = length * 3600;
    }

    /**
    * @dev Returns a boolean indicating whether the private sale
    *      phase is currently active.
    */
    function isPrivSaleActive() public view returns (bool) {
        return PrivSalePeriodLib.isPrivSaleActive();
    }

    /**
    * @dev Returns whether the public sale is currently
    *      active.
    */
    function isPublicSaleActive() public view returns (bool) {
        return PrivSalePeriodLib.isPublicSaleActive();
    }
}