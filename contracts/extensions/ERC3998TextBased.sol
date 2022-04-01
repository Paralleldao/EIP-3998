// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../ERC3998.sol";
import "./IERC3998TextBased.sol";

abstract contract ERC3998TextBased is ERC3998, IERC3998TextBased {
    // attribute ID => token ID => text
    mapping(uint256 => mapping(uint256 => bytes)) private _texts;

    /**
     * @dev See {IERC3998-textOf}.
     */
    function textOf(uint256 tokenId, uint256 attrId)
        public
        view
        virtual
        override
        returns (bytes memory)
    {
        return _texts[attrId][tokenId];
    }

    function attachWithText(
        uint256 tokenId,
        uint256 attrId,
        uint256 amount,
        bytes memory text
    ) public virtual override {
        super.attach(tokenId, attrId, amount);

        if (text.length > 0) {
            _texts[attrId][tokenId] = text;
        }
    }

    /**
     * @dev See {IERC3998-batchAttach}.
     */
    function batchAttachWithTexts(
        uint256 tokenId,
        uint256[] calldata attrIds,
        uint256[] calldata amounts,
        bytes[] calldata texts
    ) public virtual override {
        address operator = _msgSender();

        _beforeAttrTransfer(operator, 0, tokenId, attrIds, amounts, "");

        for (uint256 i = 0; i < attrIds.length; i++) {
            require(
                _attrExists(attrIds[i]),
                "ERC3998: batchAttach for nonexistent attribute"
            );

            if (attrBalances[attrIds[i]][tokenId] == 0) {
                attrs[tokenId].push(attrIds[i]);
            }

            if (texts[i].length > 0) {
                _texts[attrIds[i]][tokenId] = texts[i];
            }

            attrBalances[attrIds[i]][tokenId] += amounts[i];
        }

        emit TransferBatch(operator, 0, tokenId, attrIds, amounts);
    }
}
