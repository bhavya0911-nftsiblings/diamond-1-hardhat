// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { MerkleProof } from "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

library AllowlistLib {
    bytes32 constant DIAMOND_STORAGE_POSITION = keccak256("allowlistlibrary.storage");

    struct state {
        bytes32 merkleRoot;
    }

    function getState() internal pure returns (state storage _state) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            _state.slot := position
        }
    }

    /**
    * @dev Verify that provided merkle proof & leaf node combination
    *      belong to the stored merkle root.
    */
    function validateProof(bytes32[] calldata proof, address leaf) internal view returns (bool) {
        return MerkleProof.verify(
            proof,
            getState().merkleRoot,
            keccak256(abi.encodePacked(leaf))
        );
    }

    /**
    * @dev Require that the caller and the provided merkle proof
    *      belong to the stored merkle root.
    */
    function requireValidProof(bytes32[] calldata proof) internal view {
        require(validateProof(proof, msg.sender), "AllowlistFacet: invalid merkle proof");
    }
}