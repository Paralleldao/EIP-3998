// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../ERC3998.sol";
import "./IERC3998Upgradable.sol";

abstract contract ERC3998Upgradable is ERC3998, IERC3998Upgradable {
    // attribute ID => settings
    mapping(uint256 => uint8) public settings;

    // attribute ID => token ID => current Level
    mapping(uint256 => mapping(uint256 => uint8)) private _levels;

    function levelOf(uint256 _tokenId, uint256 _attrId)
        public
        view
        virtual
        override
        returns (uint8)
    {
        return _levels[_attrId][_tokenId];
    }

    function mintWithLevel(
        uint256 attrId,
        string memory name,
        string memory symbol,
        string memory uri,
        uint8 maxLevel
    ) public virtual override {
        super._mint(attrId, name, symbol, uri);

        settings[attrId] = maxLevel;
    }

    function upgrade(
        uint256 _tokenId,
        uint256 _attrId,
        uint8 _level
    ) public virtual override {
        require(
            _hasAttr(_tokenId, _attrId),
            "ERC3998Upgradable: token has not attached the attribute"
        );
        require(
            _level <= settings[_attrId],
            "ERC3998Upgradable: exceeded the maximum level"
        );
        require(
            _level == _levels[_attrId][_tokenId] + 1,
            "ERC3998Upgradable: invalid level"
        );

        _levels[_attrId][_tokenId] = _level;

        emit AttributeUpgraded(_tokenId, _attrId, _level);
    }
}
