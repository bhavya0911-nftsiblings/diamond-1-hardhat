const { expect } = require("chai");
const { ethers } = require("hardhat");
const { deployDiamond } = require("../scripts/deploy.js");

describe("OpenEdition_721A_NoPriveSale Templete", () => {

    beforeEach(async () => {

        diamond = await deployDiamond();
        AdminPauseFacet = await ethers.getContractAt('AdminPauseFacet', diamond);
        DiamondCutFacet = await ethers.getContractAt('DiamondCutFacet', diamond);
        DiamondLoupeFacet = await ethers.getContractAt('DiamondLoupeFacet', diamond);
        OpenEditionFacet = await ethers.getContractAt('OpenEditionFacet', diamond);
        OwnershipFacet = await ethers.getContractAt('OwnershipFacet', diamond);
        RoyaltiesConfigFacet = await ethers.getContractAt('RoyaltiesConfigFacet', diamond);
        TokenFacet = await ethers.getContractAt('TokenFacet', diamond);
        [owner, address1, address2] = await ethers.getSigners();
        
        _uri = "https://gateway.pinata.cloud/ipfs/../";
        _walletCap = 20;
        _price = ethers.BigNumber.from(ethers.utils.parseEther("0.01"));
        _name = "MyToken";
        _symbol = "MTK";
        _salesLength = 24;
        _payees = [owner.address];
        _shares = [100];
        royaltyBPS = ethers.BigNumber.from(1000);

    
    });

    describe("Deployment", () => {

        it("Checking internal minting logic", async () => {

            const numberOfToken = 1;
            const tx = await TokenFacet.reserve(numberOfToken);
            const receipt = await tx.wait();
            expect(receipt.status).to.equal(1);
            for(let i = 0; i < numberOfToken; i++) {
                expect(await TokenFacet.ownerOf(i)).to.equal(owner.address);
            }

        });

        // it("Checking all the public variables to be as expected", async () => {
            
        //     expect(await TokenFacet.burnState()).to.equal(false);
        //     expect(await TokenFacet.walletCap()).to.equal(_walletCap);
        //     expect(await TokenFacet.price()).to.equal(_price);
        //     expect(await TokenFacet.name()).to.equal(_name);
        //     expect(await TokenFacet.symbol()).to.equal(_symbol);
        //     expect(await OpenEditionFacet.saleLength()).to.equal(_salesLength * 3600);
        //    // expect(await TokenFacet.payee(0)).to.equal(_payees[0]);
        //    // expect(await TokenFacet.shares(_payees[0])).to.equal(_shares[0]);
        //     expect(await TokenFacet.owner()).to.equal(owner.address);
        //     const resultRoyaltyRecipient = (await RoyaltiesConfigFacet.getFeeRecipients(0))[0];
        //     expect(resultRoyaltyRecipient).to.equal(owner.address);
        //     const resultRoyaltyBps = (await RoyaltiesConfigFacet.getFeeBps(0))[0];
        //     expect(resultRoyaltyBps).to.equal(royaltyBPS);
        //     await TokenFacet.reserve(1);
        //     expect(await TokenFacet.tokenURI(0)).to.equal(_uri + "0");

        // });

    });

    // describe("Check setBaseURI function", () => {

    //     beforeEach(async () => {

    //         await MyToken.reserve(1);
    //         expect(await MyToken.tokenURI(0)).to.equal(_uri + "0");
    //         newURI = "https://paymentgateway.com/../";

    //     });

    //     it("Setting new uri and checking it", async () => {

    //         await MyToken.setBaseURI(newURI);
    //         expect(await MyToken.tokenURI(0)).to.equal(newURI + "0"); 

    //     });

    //     it("Checking for non-Admins to get reverted", async () => {

    //         await expect(MyToken.connect(address1).setBaseURI(newURI))
    //         .to.be.revertedWith("AdminPrivileges: caller is not an admin");
    //         expect(await MyToken.tokenURI(0)).to.equal(_uri + "0");

    //     });

    // });

    // describe("Check setPrice function", () => {

    //     beforeEach(async () => {

    //         expect(await MyToken.price()).to.equal(_price);
    //         newPrice = 134030;

    //     });
        
    //     it("Setting new price and checking it", async () => {

    //         await MyToken.setPrice(newPrice);
    //         expect(await MyToken.price()).to.equal(newPrice);

    //     });

    //     it("Checking for non-Admins to get reverted", async () => {

    //         await expect(MyToken.connect(address1).setPrice(newPrice))
    //         .to.be.revertedWith("AdminPrivileges: caller is not an admin");
    //         expect(await MyToken.price()).to.equal(_price);

    //     });

    // });

    // describe("Check setWalletCap function", () => {

    //     beforeEach(async () => {

    //         expect(await MyToken.walletCap()).to.equal(_walletCap);
    //         newWalletCap = 134;

    //     });

    //     it("Setting new walletCap and checking it", async () => {

    //         await MyToken.setWalletCap(newWalletCap);
    //         expect(await MyToken.walletCap()).to.equal(newWalletCap);

    //     });

    //     it("Checking for non-Admins to get reverted", async () => {

    //         await expect(MyToken.connect(address1).setWalletCap(newWalletCap))
    //         .to.be.revertedWith("AdminPrivileges: caller is not an admin")
    //         expect(await MyToken.walletCap()).to.equal(_walletCap);

    //     });

    // });

    // describe("Check toggleBurnState function", () => {

    //     beforeEach(async () => {

    //         expect(await MyToken.burnState()).to.equal(false);

    //     });
        
    //     it("Flipping burnState and checking it", async () => {

    //         await MyToken.toggleBurnState();
    //         expect(await MyToken.burnState()).to.equal(true);
    //         await MyToken.toggleBurnState();
    //         expect(await MyToken.burnState()).to.equal(false);

    //     });

    //     it("Checking for non-Admins to get reverted", async () => {

    //         await expect(MyToken.connect(address1).toggleBurnState())
    //         .to.be.revertedWith("AdminPrivileges: caller is not an admin");
    //         expect(await MyToken.burnState()).to.equal(false);

    //     });

    // });

    // describe("Check reserve function", () => {

    //     beforeEach(async () => {

    //         numberOfToken = 5;
    //         alreadyMinted = await MyToken.totalSupply();
    //         ownerAlreadyMinted = await MyToken.balanceOf(owner.address);

    //     });

    //     it("Mint certain tokens and check they are delivered to owner", async () => {
            
    //         await MyToken.reserve(numberOfToken);
    //         expect(await MyToken.totalSupply()).to.equal(alreadyMinted + numberOfToken);
    //         expect(await MyToken.balanceOf(owner.address)).to.equal(ownerAlreadyMinted + numberOfToken);
    //         for(let i = 0; i < numberOfToken; i++){
    //             expect(await MyToken.ownerOf(i)).to.equal(owner.address);
    //             expect(await MyToken.tokenURI(i)).to.equal(_uri + i);
    //         }

    //     });

    //     it("Checking for non-Admins to get reverted", async () => {

    //         await expect(MyToken.connect(address1).reserve(numberOfToken))
    //         .to.be.revertedWith("AdminPrivileges: caller is not an admin");
    //         expect(await MyToken.totalSupply()).to.equal(alreadyMinted);

    //     });

    // });

    // describe("Check mint function", () => {

    //     beforeEach(async () => {    

    //         await MyToken.reserve(5);
    //         numberOfToken = 1;
    //         totalSupply = await MyToken.totalSupply();
    //         mintedByAddress1 = await MyToken.balanceOf(address1.address);
    //         amountToBeSend = _price.mul(numberOfToken);
    //         expect(await MyToken.paused()).to.equal(false);
    //         const check = ethers.BigNumber.from(mintedByAddress1).lt(_walletCap);
    //         expect(check).to.equal(true);
    //         await MyToken.beginSale();

    //     });

    //     it("Mint as intended", async () => {

    //         expect(await MyToken.connect(address1).mint(numberOfToken, {value: amountToBeSend}))
    //         .to.changeEtherBalance(address1, "-5000");
    //         expect(await MyToken.totalSupply()).to.equal(totalSupply.add(numberOfToken));
    //         const expectedTotalSupply = totalSupply.add(numberOfToken);
    //         expect(await MyToken.ownerOf(expectedTotalSupply - 1)).to.equal(address1.address);
    //         expect(await MyToken.balanceOf(address1.address)).to.equal(mintedByAddress1 + numberOfToken);
        
    //     });

    //     it("Test for inappropriate amount send", async () => {

    //         await expect(MyToken.connect(address1).mint(numberOfToken, {value: 10913443}))
    //         .to.be.revertedWith("Incorrect amount of Ether");
    //         expect(await MyToken.totalSupply()).to.equal(totalSupply);
    //         const expectedTotalSupply = totalSupply.add(numberOfToken);
    //         await expect(MyToken.ownerOf(expectedTotalSupply - 1))
    //         .to.be.revertedWith("OwnerQueryForNonexistentToken");
    //         expect(await MyToken.balanceOf(address1.address)).to.equal(mintedByAddress1);
        
    //     });

    //     it("Test for whenNotPaused modifier", async () => {

    //         await MyToken.togglePause();
    //         await expect(MyToken.connect(address1).mint(numberOfToken, {value: amountToBeSend}))
    //         .to.be.revertedWith("AdminPausable: contract is paused");
    //         expect(await MyToken.totalSupply()).to.equal(totalSupply);
    //         const expectedTotalSupply = totalSupply.add(numberOfToken);
    //         await expect(MyToken.ownerOf(expectedTotalSupply - 1))
    //         .to.be.revertedWith("OwnerQueryForNonexistentToken");
    //         expect(await MyToken.balanceOf(address1.address)).to.equal(mintedByAddress1);
        
    //     });

    //     it("Test for onlyDuringSale modifier", async () => {

    //         await passOneDay();
    //         await expect(MyToken.connect(address1).mint(numberOfToken, {value: amountToBeSend}))
    //         .to.be.revertedWith("Sale is not available now");
    //         expect(await MyToken.totalSupply()).to.equal(totalSupply);
    //         const expectedTotalSupply = totalSupply.add(numberOfToken);
    //         await expect(MyToken.ownerOf(expectedTotalSupply - 1))
    //         .to.be.revertedWith("OwnerQueryForNonexistentToken");
    //         expect(await MyToken.balanceOf(address1.address)).to.equal(mintedByAddress1);
        
    //     });

    //     it("Test for walletCap", async () => {

    //         const _amountToBeSend = _price.mul(_walletCap);
    //         await MyToken.connect(address1).mint(_walletCap, {value: _amountToBeSend});
    //         await expect(MyToken.connect(address1).mint(numberOfToken, {value: amountToBeSend}))
    //         .to.be.revertedWith("Maximum tokens per wallet is 20");
    //         expect(await MyToken.totalSupply()).to.equal(totalSupply.add(_walletCap));
    //         const expectedTotalSupply = totalSupply.add(_walletCap + 1);
    //         await expect(MyToken.ownerOf(expectedTotalSupply - 1))
    //         .to.be.revertedWith("OwnerQueryForNonexistentToken");
    //         expect(await MyToken.balanceOf(address1.address)).to.equal(mintedByAddress1.add(_walletCap));
        
    //     });
        
    // });

    // describe("Check burn function", () => {

    //     beforeEach(async () => {
            
    //         numberOfToken = 5;
    //         numberAlreadyMinted = await MyToken.totalSupply();
    //         numberOwnerAlreadyMinted = await MyToken.balanceOf(address1.address);
    //         await MyToken.reserve(numberOfToken);
    //         for(let i = 0; i < 5; i++) {
    //             await MyToken.transferFrom(owner.address, address1.address, i);
    //         }
    //         newTotalSupply = ethers.BigNumber.from(numberAlreadyMinted).add(numberOfToken);
    //         expect(await MyToken.totalSupply()).to.equal(newTotalSupply);
    //         expect(await MyToken.balanceOf(address1.address)).to.equal(numberOwnerAlreadyMinted + numberOfToken);
    //         expect(await MyToken.paused()).to.equal(false);
    //         if(!(await MyToken.burnState())) {
    //             await MyToken.toggleBurnState();
    //         }
    //         for(let i = 0; i < numberOfToken; i++){
    //             expect(await MyToken.ownerOf(i)).to.equal(address1.address);
    //             expect(await MyToken.tokenURI(i)).to.equal(_uri + i);
    //         }

    //     });

    //     it("Burn the token as intended", async () => {

    //         const numberOfTokenToBurn = 3;
    //         for(let i = 0; i < (numberOfTokenToBurn * 2); i = i + 2) {
    //             await MyToken.connect(address1).burn(i);
    //         }
    //         expect(await MyToken.totalSupply()).to.equal(newTotalSupply - numberOfTokenToBurn);
    //         expect(await MyToken.balanceOf(address1.address)).to.equal(numberOwnerAlreadyMinted + numberOfToken - numberOfTokenToBurn);
    //         for(let i = 0; i < 6; i = i + 2) {
    //             await expect(MyToken.ownerOf(i))
    //             .to.be.revertedWith("OwnerQueryForNonexistentToken");
    //         }

    //     });

    //     it("Burn stopped when burnState is set to false", async () => {

    //         await MyToken.toggleBurnState();
    //         await expect(MyToken.burn(0))
    //         .to.be.revertedWith("Token burning is not available now");

    //     });

    //     it("Burn stopped when paused", async () => {

    //         await MyToken.togglePause();
    //         expect(await MyToken.paused()).to.equal(true);
    //         await expect(MyToken.connect(address1).burn(0))
    //         .to.be.revertedWith("AdminPausable: contract is paused");

    //     });

    //     it("Token can only burn token by owner", async () => {

    //         await MyToken.reserve(1);
    //         const currentTokenId = (await MyToken.totalSupply()) - 1;
    //         expect(await MyToken.ownerOf(currentTokenId)).to.equal(owner.address);
    //         await expect(MyToken.connect(address1).burn(currentTokenId))
    //         .to.be.reverted;
    //         const tx = await MyToken.burn(currentTokenId);
    //         const receipt = await tx.wait();
    //         expect(receipt.status).to.equal(1);

    //     });
    // });

    // describe("Check supportsInterface function", () => {

    //     beforeEach(async () => {

    //         raribleInterfaceID = 0xb7799584;
    //         EIP2981InterfaceID = 0x2a55205a;
    //         ERC165InterfaceID = 0x01ffc9a7;
    //         ERC721InterfaceID = 0x80ac58cd;
    //         ERC721MetadataInterfaceID = 0x5b5e139f;

    //     });

    //     it("Checking for Rarible Interface ID", async () => {

    //         expect(await MyToken.supportsInterface(raribleInterfaceID)).to.equal(true);
        
    //     });

    //     it("Checking for EIP2981 Interface ID", async () => {

    //         expect(await MyToken.supportsInterface(EIP2981InterfaceID)).to.equal(true);
        
    //     });

    //     it("Checking for ERC165 Interface ID", async () => {

    //         expect(await MyToken.supportsInterface(ERC165InterfaceID)).to.equal(true);
        
    //     });

    //     it("Checking for ERC721 Interface ID", async () => {

    //         expect(await MyToken.supportsInterface(ERC721InterfaceID)).to.equal(true);
        
    //     });

    //     it("Checking for ERC721Metadata Interface ID", async () => {

    //         expect(await MyToken.supportsInterface(ERC721MetadataInterfaceID)).to.equal(true);
        
    //     });

    // });

    // describe("Check _beforeTokenTransfers function", () => {

    //     beforeEach(async () => {

    //         // 1 Token sent to owner, to demonstate that admin can still access the function
    //         ownerBalance = await MyToken.balanceOf(owner.address);
    //         await MyToken.reserve(1);
    //         mintedToken = (await MyToken.totalSupply()) - 1;

    //         expect(await MyToken.isAdmin(owner.address)).to.equal(true);
    //         expect(await MyToken.isAdmin(address1.address)).to.equal(false);
    //         expect(await MyToken.isAdmin(address2.address)).to.equal(false);
    //         await MyToken.toggleAdmins([address1.address]);
    //         expect(await MyToken.isAdmin(owner.address)).to.equal(true);
    //         expect(await MyToken.isAdmin(address1.address)).to.equal(true);
    //         expect(await MyToken.isAdmin(address2.address)).to.equal(false);
            
    //         numberOfToken = 1;
    //         currentBalance = await MyToken.balanceOf(address1.address);
    //         currentTotalSupply = await MyToken.totalSupply();
    //         mintedTokenIDs = [];
    //         await MyToken.connect(address1).reserve(numberOfToken);
    //         expect(await MyToken.balanceOf(address1.address)).to.equal(currentBalance + numberOfToken);
    //         for(let i = 0; i < numberOfToken; i++){
    //             tokenID = (await MyToken.totalSupply() - 1) + i;
    //             expect(await MyToken.ownerOf(tokenID)).to.equal(address1.address);
    //             mintedTokenIDs[i] = tokenID;
    //         }

    //         await MyToken.toggleAdmins([address1.address]);
    //         expect(await MyToken.isAdmin(owner.address)).to.equal(true);
    //         expect(await MyToken.isAdmin(address1.address)).to.equal(false);
    //         expect(await MyToken.isAdmin(address2.address)).to.equal(false);

    //     });
        
    //     it("Working when not paused", async () => {

    //         if(await MyToken.paused()) {
    //             await MyToken.togglePause();
    //         }
    //         expect(await MyToken.paused()).to.equal(false);

    //         const tx = await MyToken.transferFrom(owner.address, address1.address, mintedToken);
    //         const receipt = await tx.wait();
    //         expect(receipt.status).to.equal(1);
    //         expect(await MyToken.ownerOf(mintedToken)).to.equal(address1.address);
    //         expect(await MyToken.balanceOf(owner.address)).to.equal(ownerBalance);
    //         expect(await MyToken.balanceOf(address1.address)).to.equal(ethers.BigNumber.from(currentBalance + numberOfToken).add(1));

    //         const newAddressBalance = await MyToken.balanceOf(address2.address);
    //         const tx1 = await MyToken.connect(address1).transferFrom(address1.address, address2.address, mintedTokenIDs[0]);
    //         const receipt1 = await tx.wait();
    //         expect(receipt1.status).to.equal(1);
    //         expect(await MyToken.ownerOf(mintedTokenIDs[0])).to.equal(address2.address);
    //         expect(await MyToken.balanceOf(address1.address)).to.equal(currentBalance + numberOfToken);
    //         expect(await MyToken.balanceOf(address2.address)).to.equal(newAddressBalance + 1);

    //     });

    //     it("Not working when paused", async () => {

    //         if(!(await MyToken.paused())){
    //             await MyToken.togglePause();
    //         }
    //         expect(await MyToken.paused()).to.equal(true);
            
    //         const tx = await MyToken.transferFrom(owner.address, address1.address, mintedToken);
    //         const receipt = await tx.wait();
    //         expect(receipt.status).to.equal(1);
    //         expect(await MyToken.ownerOf(mintedToken)).to.equal(address1.address);
    //         expect(await MyToken.balanceOf(owner.address)).to.equal(ownerBalance);
    //         expect(await MyToken.balanceOf(address1.address)).to.equal(ethers.BigNumber.from(currentBalance + numberOfToken).add(1));

    //         const newAddressBalance = await MyToken.balanceOf(address2.address);
    //         await expect(MyToken.connect(address1).transferFrom(address1.address, address2.address, mintedTokenIDs[0]))
    //         .to.be.revertedWith("dminPausable: contract is paused");
    //         expect(await MyToken.ownerOf(mintedTokenIDs[0])).to.equal(address1.address);
    //         expect(await MyToken.balanceOf(address1.address)).to.equal(ethers.BigNumber.from(currentBalance + numberOfToken).add(1));
    //         expect(await MyToken.balanceOf(address2.address)).to.equal(newAddressBalance);
        
    //     });

    // });

});