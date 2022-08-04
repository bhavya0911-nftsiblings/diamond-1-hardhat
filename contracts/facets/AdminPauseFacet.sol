// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { GlobalState } from "../libraries/GlobalState.sol";

contract AdminPauseFacet {
    event Paused(address account);
    event Unpaused(address account);

    function paused() public view returns (bool) {
        return GlobalState.getState().paused;
    }

    function togglePause() public {
        GlobalState.requireCallerIsAdmin();
        if (GlobalState.togglePause()) {
            emit Paused(msg.sender);
        } else {
            emit Unpaused(msg.sender);
        }
    }
}