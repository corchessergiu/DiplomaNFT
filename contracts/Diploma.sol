// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract DiplomaNFT is
    ERC721Enumerable,
    AccessControl,
    ReentrancyGuard,
    Ownable
{
    using Strings for uint256;

    // Prefix for tokens metadata URI
    string public baseURI;

    // Suffix for tokens metadata URIs
    string public baseExtension = ".json";

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _initBaseURI
    ) ERC721(_name, _symbol) Ownable(msg.sender) {
        setBaseURI(_initBaseURI);
    }

    function mintDiploma(
        address _to
    ) external nonReentrant onlyOwner returns (uint256 tokenId) {
        tokenId = totalSupply() + 1;
        _safeMint(_to, tokenId);
        return tokenId;
    }

    /**
     * @dev Returns the current base URI.
     * @return The base URI of the contract.
     */
    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    /**
     * @dev This function sets the base URI of the NFT contract.
     * @param _newBaseURI The new base URI of the NFT contract.
     * @notice Only the contract owner can call this function.
     */
    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }

    /**
     * @dev Returns the token URI for the given token ID. Throws if the token ID does not exist
     * @param tokenId The token ID to retrieve the URI for
     * @notice Retrieve the URI for the given token ID
     * @return The token URI for the given token ID
     */
    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        require(
            _requireOwned(tokenId) != address(0),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory currentBaseURI = _baseURI();
        return
            bytes(currentBaseURI).length > 0
                ? string(
                    abi.encodePacked(
                        currentBaseURI,
                        tokenId.toString(),
                        baseExtension
                    )
                )
                : "";
    }

    /**
     * Changes the base extension for token metadata
     *
     * Access: only the admin account
     *
     * @param _newBaseExtension new value
     */
    function setBaseExtension(string memory _newBaseExtension) public onlyOwner{
        baseExtension = _newBaseExtension;
    }

    /**
     * Returns the complete metadata URI for the given tokenId.
     */
    function walletOfOwner(
        address _owner
    ) public view returns (uint256[] memory) {
        uint256 ownerTokenCount = balanceOf(_owner);
        uint256[] memory tokenIds = new uint256[](ownerTokenCount);
        for (uint256 i; i < ownerTokenCount; i++) {
            tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
        }
        return tokenIds;
    }

    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721Enumerable, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
