// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { GlobalState } from "../libraries/GlobalState.sol";
import { AllowlistLib } from "../libraries/AllowlistLib.sol";

contract AdminPauseFacet {
    /**
    * @dev Get stored Merkle root.
    */
    function merkleRoot() public view returns (bytes32) {
        return AllowlistLib.getState().merkleRoot;
    }
    
    /**
    * @dev Set Merkle root.
    */
    function setMerkleRoot(bytes32 root) public {
        GlobalState.requireCallerIsAdmin();
        AllowlistLib.getState().merkleRoot = root;
    }
}