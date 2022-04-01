// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC3998Metadata.sol";

/**
 * @dev Interface for the updatable functions from the ERC3998.
 */
interface IERC3998Updatable is IERC3998Metadata {
    /**
     * @dev Remove attribute type `attrId` from `tokenId`.
     */
    function remove(uint256 tokenId, uint256 attrId) external;

    /**
     * @dev Increases `amount` value of attribute type `attrId` to `tokenId`.
     */
    function increase(
        uint256 tokenId,
        uint256 attrId,
        uint256 amount
    ) external;

    /**
     * @dev Decreases `amount` value of attribute type `attrId` from `tokenId`.
     */
    function decrease(
        uint256 tokenId,
        uint256 attrId,
        uint256 amount
    ) external;
}
