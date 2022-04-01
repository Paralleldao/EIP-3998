// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC3998Metadata.sol";

/**
 * @dev Interface for the Evolvable functions from the ERC3998.
 */
interface IERC3998Evolvable is IERC3998Metadata {
    event AttributeEvolvable(
        address indexed operator,
        uint256 tokenId,
        uint256 attrId,
        bool status
    );

    event AttributeRepaired(
        address indexed operator,
        uint256 tokenId,
        uint256 attrId
    );

    function period(uint256 tokenId, uint256 attrId)
        external
        view
        returns (uint256);

    function evolutive(uint256 tokenId, uint256 attrId) external;

    function repair(uint256 tokenId, uint256 attrId) external;
}
