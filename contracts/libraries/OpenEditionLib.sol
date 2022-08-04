// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library OpenEditionLib {
    bytes32 constant DIAMOND_STORAGE_POSITION = keccak256("openeditionlibrary.storage");

    struct state {
        uint256 saleLength;
        uint256 saleTimestamp;
    }

    function getState() internal pure returns (state storage _state) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            _state.slot := position
        }
    }

    /**
     * @dev Check whether the sale is currently active.
     */
    function isSaleActive() internal view returns (bool) {
        uint256 ts = getState().saleTimestamp;
        return
            ts != 0 &&
            block.timestamp >= ts &&
            block.timestamp < ts + getState().saleLength;
    }
}