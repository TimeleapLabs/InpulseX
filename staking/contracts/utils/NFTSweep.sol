// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "../interfaces/IERC721.sol";

contract NFTSweep {
    /**
     * @dev Returns a list of NFTs owned by the user
     * @param nft Address of the ERC721 NFT contract
     * @param user Address of the user
     * @param start Start NFT ID for lookup
     * @param end End NFT ID to lookup
     * @return uint256[] NFTs owned by `user`
     */
    function performNftSweep(
        address nft,
        address user,
        uint256 start,
        uint256 end
    ) external view returns (uint256[] memory, uint256) {
        uint256[] memory NFTs = new uint256[](100);
        IERC721 nftContract = IERC721(nft);
        uint256 id = start;
        uint256 i = 0;
        for (id; id < end && i <= 100; id++) {
            if (nftContract.ownerOf(id) == user) {
                NFTs[i++] = id;
            }
        }
        return (NFTs, id);
    }
}
