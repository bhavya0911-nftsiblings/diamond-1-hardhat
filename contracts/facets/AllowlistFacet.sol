// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { GlobalState, state } from "../libraries/GlobalState.sol";
import { AllowlistLibrary } from "../libraries/AllowlistLibrary.sol";

contract AdminPauseFacet {
    /**
    * @dev Get stored Merkle root.
    */
    function merkleRoot() public view returns (bytes32) {
        return AllowlistLibrary.getState().merkleRoot;
    }
    
    /**
    * @dev Set Merkle root.
    */
    function setMerkleRoot(bytes32 root) public {
        GlobalState.requireCallerIsAdmin();
        AllowlistLibrary.getState().merkleRoot = root;
    }
}