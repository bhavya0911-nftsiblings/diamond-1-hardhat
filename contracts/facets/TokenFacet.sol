//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { GlobalState } from "../libraries/GlobalState.sol";
import { TokenState } from "../libraries/TokenState.sol";
import "../libraries/TokenLib.sol";
import { OpenEditionLib } from "../libraries/OpenEditionLib.sol";


contract TokenFacet is ERC721A {

    constructor()
    ERC721A("MyToken", "MTK") {}

    // SETUP & ADMIN FUNCTIONS //

    function setBaseURI(string memory _uri) public {
        GlobalState.requireCallerIsAdmin();
        TokenState.getState().uri = _uri;
    }

    function setPrice(uint256 _price) public {
        GlobalState.requireCallerIsAdmin();
        TokenState.getState().price = _price;
    }

    function setWalletCap(uint256 _walletCap) public {
        GlobalState.requireCallerIsAdmin();
        TokenState.getState().walletCap = _walletCap;
    }

    function toggleBurnState() public {
        GlobalState.requireCallerIsAdmin();
        TokenState.getState().burnState = !TokenState.getState().burnState;
    }

    function reserve(uint256 amount) public {
        GlobalState.requireCallerIsAdmin();
        _safeMint(msg.sender, amount);
    }

    // PUBLIC FUNCTIONS //

    function mint(uint256 amount) 
        public 
        payable 
    {
        GlobalState.requireContractIsNotPaused();
        require(OpenEditionLib.isSaleActive(), "Sale is not active");
        require(amount * TokenState.getState().price == msg.value, "Incorrect amount of Ether");
        require(
            amount + _numberMinted(msg.sender) <= TokenState.getState().walletCap,
            string(
                abi.encodePacked(
                    "Maximum tokens per wallet is ",
                    _toString(TokenState.getState().walletCap)
                )
            )
        );
        _safeMint(msg.sender, amount);
    }

    function burn(uint256 tokenId) public {
        GlobalState.requireContractIsNotPaused();
        require(TokenState.getState().burnState, "Token burning is not available now");
        _burn(tokenId, true);
    }

    // METADATA & MISC FUNCTIONS //

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721A)
        returns (bool)
    {
        return
            ERC721A.supportsInterface(interfaceId);
    }

    function _beforeTokenTransfers(
        address from,
        address to,
        uint256 startTokenId,
        uint256 quantity
    ) internal override {
        GlobalState.requireContractIsNotPaused();
        super._beforeTokenTransfers;
    }

    function _baseURI() internal view override returns (string memory) {
        return TokenState.getState().uri;
    } 

}