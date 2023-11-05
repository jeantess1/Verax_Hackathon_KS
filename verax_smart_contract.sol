// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";


contract MyNFT is ERC721Enumerable, Ownable {

    // Base URI for metadata
    string private _baseTokenURI;
    struct NFTattribue{
        address owner;
        string description;
        string text;
        string image;
    }
    // Mapping from token ID to specific information
    mapping(uint256 => NFTattribue) public nftattribues;

    constructor(string memory name, string memory symbol, string memory baseTokenURI) ERC721(name, symbol) Ownable(msg.sender) {
        _baseTokenURI = baseTokenURI;
        
    }


    function mint(address to, string memory _description,string memory _text,string memory _image) external {
        uint256 tokenId = totalSupply() + 1;
        _mint(to, tokenId);
        
        nftattribues[tokenId] = NFTattribue(to,_description,_text,_image) ;

        
    }

    function tokenData(uint256 tokenId) public view returns (address, string memory, string memory, string memory) 
    {     
        NFTattribue memory attrib = nftattribues[tokenId];     
        return (attrib.owner, attrib.description, attrib.text, attrib.image); 
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory baseURI = _baseTokenURI;
        return bytes(baseURI).length > 0
            ? string(abi.encodePacked(baseURI, Strings.toString(tokenId)))
            : '';

    } 
    function totalsupply() public view returns (uint256) 
    {     
        return totalSupply(); 
    }
}