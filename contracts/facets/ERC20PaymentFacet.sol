// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { GlobalState, state } from "../libraries/GlobalState.sol";
import { ERC20PaymentLibrary } from "../libraries/ERC20PaymentLibrary.sol";

contract ERC20PaymentFacet {
    /**
    * @dev Get stored address of ERC20 token to be paid.
    */
    function ERC20Address() public view returns (address) {
        return ERC20PaymentLibrary.getState().ERC20Address;
    }

    /**
    * @dev Set details of ERC20 token.
    */
    function setERC20(address _ERC20Address) public {
        GlobalState.requireCallerIsAdmin();
        ERC20PaymentLibrary.getState().ERC20Address = _ERC20Address;
    }

    /**
    * @dev Set payout address for ERC20 tokens.
    */
    function setPayoutAddress(address payee) public {
        GlobalState.requireCallerIsAdmin();
        ERC20PaymentLibrary.getState().payoutAddress = payee;
    }
}