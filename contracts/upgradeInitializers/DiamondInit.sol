// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/******************************************************************************\
* Author: Nick Mudge <nick@perfectabstractions.com> (https://twitter.com/mudgen)
* EIP-2535 Diamonds: https://eips.ethereum.org/EIPS/eip-2535
*
* Implementation of a diamond.
/******************************************************************************/

import { GlobalState } from "../libraries/GlobalState.sol";
import { LibDiamond } from "../libraries/LibDiamond.sol";
import { IDiamondLoupe } from "../interfaces/IDiamondLoupe.sol";
import { IDiamondCut } from "../interfaces/IDiamondCut.sol";
import { IERC173 } from "../interfaces/IERC173.sol";
import { IERC165 } from "../interfaces/IERC165.sol";
import { IERC721 } from "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import { IERC721Metadata } from "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
import { TokenState } from "../libraries/TokenState.sol";

contract DiamondInit {    

    function init() external {

        LibDiamond.DiamondStorage storage ds = LibDiamond.diamondStorage();
        TokenState.State storage ts = TokenState.getState();
        GlobalState.state storage gs = GlobalState.getState();
        ds.supportedInterfaces[type(IERC165).interfaceId] = true;
        ds.supportedInterfaces[type(IDiamondCut).interfaceId] = true;
        ds.supportedInterfaces[type(IDiamondLoupe).interfaceId] = true;
        ds.supportedInterfaces[type(IERC173).interfaceId] = true;
        ds.supportedInterfaces[type(IERC721).interfaceId] = true;
        ds.supportedInterfaces[type(IERC721Metadata).interfaceId] = true;
        ds.supportedInterfaces[0x2a55205a] = true; // On-Chain Royalty interface Id
        
        gs.owner = msg.sender;

        ts._name = "MyToken";
        ts._symbol = "MTK";
        ts.uri = "https://gateway.pinata.cloud/ipfs/../";
        ts.walletCap = 20;
        ts.price = 0.01 ether;

    }
}
