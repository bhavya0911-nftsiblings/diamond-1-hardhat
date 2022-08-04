// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { IERC20 } from "@openzeppelin/contracts/interfaces/IERC20.sol";

library ERC20PaymentLibrary {
    bytes32 constant DIAMOND_STORAGE_POSITION = keccak256("erc20paymentlibrary.storage");

    struct state {
        address ERC20Address;
        address payoutAddress;
    }

    function getState() internal pure returns (state storage _state) {
        bytes32 position = DIAMOND_STORAGE_POSITION;
        assembly {
            _state.slot := position
        }
    }

    /**
    * @dev Pays the given amount of ERC20 tokens from the given
    * address to the payout address.
    */
    function payERC20(address from, uint amount) internal {
        require(
            IERC20(getState().ERC20Address).transferFrom(from, getState().payoutAddress, amount),
            "ERC20PaymentFacet: ERC20 payment failed"
        );
    }

    /**
    * @dev Queries the ERC20 token balance of an address.
    */
    function ERC20BalanceOf(address _addr) internal view returns (uint) {
        return IERC20(getState().ERC20Address).balanceOf(_addr);
    }
}