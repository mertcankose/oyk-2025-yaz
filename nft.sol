// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract OYKNft is ERC721, ERC721URIStorage, Ownable {
    uint256 private _nextTokenId;
    
    constructor(string memory name, string memory symbol) ERC721(name, symbol) Ownable(msg.sender) {
        _nextTokenId = 1;
    }
    
    function mint(address to, string memory uri) public onlyOwner returns (uint256) {
        uint256 tokenId = _nextTokenId;
        _nextTokenId++;
        
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
        
        return tokenId;
    }
    
    // Override
    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }
    
    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
    /*
    Diğer kontratlar veya dApp'ler sizin NFT'nizin hangi özellikleri desteklediğini kontrol edebilir:
    
    // Örnek kullanım
    if (nftContract.supportsInterface(0x80ac58cd)) { // ERC721 interface ID
        // Bu bir NFT kontratı
    }
    if (nftContract.supportsInterface(0x5b5e139f)) { // ERC721Metadata interface ID  
        // Bu NFT metadata destekliyor
    }
    */
}
