// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library GlobalState {
    // GLOBAL STORAGE //

    bytes32 constant DIAMOND_STORAGE_POSITION = keccak256("globalstate.storage");

    struct state {
        address owner;
        mapping(address => bool) admins;

        bool paused;
    }

    function getState() internal pure returns (state storage _state) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            _state.slot := position
        }
    }

    // OWNERSHIP FACET //

    function isAdmin(address _addr) internal view returns (bool) {
        state storage ds = getState();
        return ds.owner == _addr || ds.admins[_addr];
    }

    function requireCallerIsAdmin() internal view {
        require(isAdmin(msg.sender), "GlobalState: caller must be an admin");
    }

    // ADMINPAUSE FACET //

    function togglePause() internal returns (bool) {
        bool priorStatus = getState().paused;
        getState().paused = !priorStatus;
        return !priorStatus;
    }

    function requireContractIsNotPaused() internal view {
        require(!getState().paused);
    }
}