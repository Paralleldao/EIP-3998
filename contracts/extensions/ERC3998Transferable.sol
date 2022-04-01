// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../ERC3998.sol";
import "../utils/ITokenHolder.sol";
import "./IERC3998Transferable.sol";

/**
 * @dev Implementation of the {ERC3998Transferable} interface.
 */
abstract contract ERC3998Transferable is ERC3998, IERC3998Transferable {
    // attribute ID => from token ID => to token ID
    mapping(uint256 => mapping(uint256 => uint256)) private _allowances;

    address private _nft;

    modifier onlyHolder(uint256 tokenId) {
        require(
            ITokenHolder(_nft).holderOf(tokenId) == _msgSender(),
            "ERC3998Transferable: caller is not the nft holder"
        );
        _;
    }

    constructor(address nft, string memory uri_) ERC3998(uri_) {
        _nft = nft;
    }

    /**
     * @dev See {IERC3998Transferable-isApproved}.
     */
    function isApproved(
        uint256 from,
        uint256 to,
        uint256 attrId
    ) public view virtual override returns (bool) {
        return _allowances[attrId][from] == to;
    }

    /**
     * @dev See {IERC3998Transferable-approve}.
     */
    function approve(
        uint256 from,
        uint256 to,
        uint256 attrId
    ) public virtual override onlyHolder(from) {
        require(
            from != 0,
            "ERC3998Transferable: approve from the zero address"
        );
        require(to != 0, "ERC3998Transferable: approve to the zero address");
        require(
            !_hasAttr(to, attrId),
            "ERC3998Transferable: recipient token has already attached the attribute"
        );

        _allowances[attrId][from] = to;

        emit AttributeApproval(_msgSender(), from, to, attrId);
    }

    /**
     * @dev See {IERC3998Transferable-transferFrom}.
     */
    function transferFrom(
        uint256 from,
        uint256 to,
        uint256 attrId
    ) public virtual override {
        require(
            isApproved(from, to, attrId),
            "ERC3998Transferable: nft holder not approve the attribute to recipient"
        );
        require(
            !_hasAttr(to, attrId),
            "ERC3998Transferable: recipient has attached the attribute"
        );

        address operator = _msgSender();
        uint256 amount = attrBalances[attrId][from];
        _beforeAttrTransfer(
            operator,
            from,
            to,
            _asSingletonArray(attrId),
            _asSingletonArray(amount),
            ""
        );

        attrBalances[attrId][to] = amount;
        delete attrBalances[attrId][from];
        delete _allowances[attrId][from];

        emit TransferSingle(operator, from, to, attrId, amount);
    }
}
