// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library PrivSalePeriodLib {
    bytes32 constant DIAMOND_STORAGE_POSITION = keccak256("privsaleperiodlibrary.storage");

    struct state {
        uint256 privSaleLength;
        uint256 saleTimestamp;
    }

    function getState() internal pure returns (state storage _state) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            _state.slot := position
        }
    }

    /**
    * @dev Returns a boolean indicating whether the private sale
    *      phase is currently active.
    */
    function isPrivSaleActive() internal view returns (bool) {
        state storage s = getState();
        return
            s.saleTimestamp != 0 &&
            block.timestamp >= s.saleTimestamp &&
            block.timestamp < s.saleTimestamp + s.privSaleLength;
    }

    /**
    * @dev Returns whether the public sale is currently
    *      active.
    */
    function isPublicSaleActive() internal view returns (bool) {
        state storage s = getState();
        return s.saleTimestamp != 0 && block.timestamp >= s.saleTimestamp + s.privSaleLength;
    }

    function requirePrivSaleIsActive() internal view {
        require(isPrivSaleActive(), "PrivSalePeriodFacet: private sale is not active now");
    }

    function requirePublicSaleIsActive() internal view {
        require(isPublicSaleActive(), "PrivSalePeriodFacet: public sale is not active now");
    }
}