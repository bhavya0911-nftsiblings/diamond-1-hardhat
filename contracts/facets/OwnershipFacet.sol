// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { GlobalState } from "../libraries/GlobalState.sol";

contract OwnershipFacet {
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    
    function owner() public view returns (address) {
        return GlobalState.getState().owner;
    }

    function transferOwnership(address newOwner) public {
        address previousOwner = owner();
        require(msg.sender == previousOwner, "OwnershipFacet: caller must be contract owner");

        GlobalState.getState().owner = newOwner;
        emit OwnershipTransferred(previousOwner, newOwner);
    }

    function isAdmin(address _addr) public view returns (bool) {
        return GlobalState.isAdmin(_addr);
    }

    function toggleAdmins(address[] calldata accounts) public {
        GlobalState.requireCallerIsAdmin();
        GlobalState.state storage _state = GlobalState.getState();

        for (uint256 i; i < accounts.length; i++) {
            if (_state.admins[accounts[i]]) {
                delete _state.admins[accounts[i]];
            } else {
                _state.admins[accounts[i]] = true;
            }
        }
    }
}