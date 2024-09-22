// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract InpulseXTiers is ERC721, ERC721Burnable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    string internal _baseUri;
    mapping(address => uint256) internal _tierMap;

    constructor() ERC721("InpulseX Tiers", "IPXT") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function setBaseURI(
        string calldata _URI
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _baseUri = _URI;
    }

    function _baseURI() internal view override returns (string memory) {
        return _baseUri;
    }

    function getTier(address user) external view returns (uint256) {
        return _tierMap[user];
    }

    function grantTier(
        address user,
        uint256 tier
    ) public onlyRole(MINTER_ROLE) {
        require(_tierMap[user] != tier, "Tier not changed");
        uint256 userShifted = (uint256(uint160(user)) << 96);
        uint256 nftId = userShifted | tier;
        safeMint(user, nftId);
        if (_tierMap[user] > 0) {
            uint256 oldNftId = userShifted | _tierMap[user];
            _burn(oldNftId);
        }
        _tierMap[user] = tier;
    }

    function grantTiers(
        address[] calldata users,
        uint256[] calldata tiers
    ) external onlyRole(MINTER_ROLE) {
        require(
            users.length == tiers.length,
            "Users and tiers don't have the same size"
        );
        for (uint i = 0; i < users.length; i++) {
            grantTier(users[i], tiers[i]);
        }
    }

    function safeMint(
        address to,
        uint256 tokenId
    ) public onlyRole(MINTER_ROLE) {
        _safeMint(to, tokenId);
    }

    function transferFrom(address, address, uint256) public pure override {
        revert("Not allowed");
    }

    function safeTransferFrom(address, address, uint256) public pure override {
        revert("Not allowed");
    }

    function safeTransferFrom(
        address,
        address,
        uint256,
        bytes memory
    ) public pure override {
        revert("Not allowed");
    }

    // The following functions are overrides required by Solidity.

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
