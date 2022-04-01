// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../ERC3998.sol";
import "./IERC3998Updatable.sol";

abstract contract ERC3998Updatable is ERC3998, IERC3998Updatable {
    /**
     * @dev See {IERC3998Updatable-remove}.
     */
    function remove(uint256 tokenId, uint256 attrId) public virtual override {
        require(
            _attrExists(attrId),
            "ERC3998Updatable: remove for nonexistent attribute"
        );
        uint256 amount = attrBalances[attrId][tokenId];
        require(
            amount > 0,
            "ERC3998Updatable: token has not attached the attribute"
        );

        address operator = _msgSender();
        _beforeAttrTransfer(
            operator,
            tokenId,
            0,
            _asSingletonArray(attrId),
            _asSingletonArray(amount),
            ""
        );

        delete attrBalances[attrId][tokenId];
        _removeByValue(attrs[tokenId], attrId);

        emit TransferSingle(operator, tokenId, 0, attrId, amount);
    }

    /**
     * @dev See {IERC3998Updatable-increase}.
     */
    function increase(
        uint256 tokenId,
        uint256 attrId,
        uint256 amount
    ) public virtual override {
        require(
            _attrExists(attrId),
            "ERC3998Updatable: increase for nonexistent attribute"
        );
        require(
            _hasAttr(tokenId, attrId),
            "ERC3998Updatable: token has not attached the attribute"
        );

        address operator = _msgSender();
        _beforeAttrTransfer(
            operator,
            0,
            tokenId,
            _asSingletonArray(attrId),
            _asSingletonArray(amount),
            ""
        );

        attrBalances[attrId][tokenId] += amount;

        emit TransferSingle(operator, 0, tokenId, attrId, amount);
    }

    /**
     * @dev See {IERC3998Updatable-decrease}.
     */
    function decrease(
        uint256 tokenId,
        uint256 attrId,
        uint256 amount
    ) public virtual override {
        require(
            _attrExists(attrId),
            "ERC3998Updatable: decrease for nonexistent attribute"
        );
        require(
            _hasAttr(tokenId, attrId),
            "ERC3998Updatable: token has not attached the attribute"
        );

        address operator = _msgSender();
        _beforeAttrTransfer(
            operator,
            tokenId,
            0,
            _asSingletonArray(attrId),
            _asSingletonArray(amount),
            ""
        );

        uint256 tb = attrBalances[attrId][tokenId];
        require(tb >= amount);
        attrBalances[attrId][tokenId] = tb - amount;

        emit TransferSingle(operator, tokenId, 0, attrId, amount);
    }
}
