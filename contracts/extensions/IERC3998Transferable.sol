// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./IERC3998Metadata.sol";

/**
 * @dev Interface for the transferable functions from the ERC3998.
 */
interface IERC3998Transferable is IERC3998Metadata {
    /**
     * @dev Emitted when  attribute type `attrId` are approved to "to" from `from` by `operator`.
     */
    event AttributeApproval(
        address indexed operator,
        uint256 from,
        uint256 to,
        uint256 attrId
    );

    /**
     * @dev Returns true if `attrId` is approved to token `to` from token `from`.
     */
    function isApproved(
        uint256 from,
        uint256 to,
        uint256 attrId
    ) external view returns (bool);

    /**
     * @dev Approve attribute type `attrId` of token `from` to token `to` called by `from` holder.
     *
     * Emits an {AttributeApproval} event.
     */
    function approve(
        uint256 from,
        uint256 to,
        uint256 attrId
    ) external;

    /**
     * @dev Transfers attribute type `attrId` from token type `from` to `to`.
     *
     * Emits a {TransferSingle} event.
     */
    function transferFrom(
        uint256 from,
        uint256 to,
        uint256 attrId
    ) external;
}
