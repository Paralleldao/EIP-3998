// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../IERC3998.sol";

/**
 * @dev Interface for the optional metadata functions from the ERC3998 standard.
 */
interface IERC3998Metadata is IERC3998 {
    /**
     * @dev Returns the name of the attribute.
     */
    function name(uint256 attrId) external view returns (string memory);

    /**
     * @dev Returns the symbol of the attribute.
     */
    function symbol(uint256 attrId) external view returns (string memory);

    /**
     * @dev Returns the Uniform Resource Identifier (URI) for `attrId` attribute.
     */
    function attrURI(uint256 attrId) external view returns (string memory);
}
