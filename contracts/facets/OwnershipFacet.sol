// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { GlobalState } from "../libraries/GlobalState.sol";
import { IERC173 } from "../interfaces/IERC173.sol";

contract OwnershipFacet is IERC173 {
    // function owner() external override view returns (address) {
    //     return GlobalState.owner();
    // }

    function owner() external override view returns (address) {
        return GlobalState.getState().owner;
    }

    function isAdmin(address _addr) external view returns (bool) {
        return GlobalState.isAdmin(_addr);
    }

    function toggleAdmins(address[] calldata accounts) external {
        GlobalState.toggleAdmins(accounts);
    }

    function transferOwnership(address _newOwner) external override {
        address previousOwner = GlobalState.owner();

        require(msg.sender == previousOwner, "OwnershipFacet: caller must be contract owner");

        GlobalState.setOwner(_newOwner);

        emit OwnershipTransferred(previousOwner, _newOwner);
    }
}
