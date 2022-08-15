//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

library TokenState {

    struct State {

    // The next token ID to be minted.
    uint256 _currentIndex;

    // The number of tokens burned.
    uint256 _burnCounter;

    // Token name
    string _name;

    // Token symbol
    string _symbol;

    // Mapping from token ID to ownership details
    // An empty struct value does not necessarily mean the token is unowned.
    // See {_packedOwnershipOf} implementation for details.
    //
    // Bits Layout:
    // - [0..159]   `addr`
    // - [160..223] `startTimestamp`
    // - [224]      `burned`
    // - [225]      `nextInitialized`
    // - [232..255] `extraData`
    mapping(uint256 => uint256) _packedOwnerships;

    // Mapping owner address to address data.
    //
    // Bits Layout:
    // - [0..63]    `balance`
    // - [64..127]  `numberMinted`
    // - [128..191] `numberBurned`
    // - [192..255] `aux`
    mapping(address => uint256) _packedAddressData;

    // Mapping from token ID to approved address.
	mapping(uint256 => address) _tokenApprovals;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) _operatorApprovals;

    string uri;

    uint256 walletCap;

    uint256 price;
    
    bool burnState;

    }

    bytes32 constant TOKEN_VAIRABLE_STORAGE_POSITION = keccak256("TokenState.Storage");

    function getState() internal pure returns (State storage s) {
        bytes32 position = TOKEN_VAIRABLE_STORAGE_POSITION;
        assembly {
            s.slot := position
        }
    }
}