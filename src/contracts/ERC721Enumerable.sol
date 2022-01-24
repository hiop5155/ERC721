// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './ERC721.sol';

 contract ERC721Enumerable is ERC721{
    uint[] private _allTokens;
    //mapping from tokenId to position in _allToken
    mapping(uint256 => uint256) private _allTokenIndex;
    //mapping of owner to list of all owner token ids
    mapping(address => uint256[]) private _ownedTokens;
    //mapping from token ID to index of the owner tokens list
    mapping(uint256 => uint256) private _ownedTokenIndex;

    /// @notice Count NFTs tracked by this contract
    /// @return A count of valid NFTs tracked by this contract, where each one of
    ///  them has an assigned and queryable owner not equal to the zero address
    function totalSupply() external view returns (uint256){
        return _allTokens.length;
    }

    /// @notice Enumerate valid NFTs
    /// @dev Throws if `_index` >= `totalSupply()`.
    /// @param _index A counter less than `totalSupply()`
    /// @return The token identifier for the `_index`th NFT,
    ///  (sort order not specified)
    function tokenByIndex(uint256 _index) external view returns (uint256){
        require(_index < this.totalSupply(), 'Error - glbal index is out of bounds');
        return _allTokenIndex[_index];
    }

    /// @notice Enumerate NFTs assigned to an owner
    /// @dev Throws if `_index` >= `balanceOf(_owner)` or if
    ///  `_owner` is the zero address, representing invalid NFTs.
    /// @param _owner An address where we are interested in NFTs owned by them
    /// @param _index A counter less than `balanceOf(_owner)`
    /// @return The token identifier for the `_index`th NFT assigned to `_owner`,
    ///   (sort order not specified)
    //override _mint function
    function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256){
        require(_index < balanceOf(_owner), 'Error - owner index is out of bounds');
        return _ownedTokens[_owner][_index];
    }

    function _mint(address to, uint256 tokenId) internal override(ERC721){
            super._mint(to, tokenId);
            /*
                1.add tokens to the owner
                2.all tokens to our totalsupply - to allTokens 
            */
            _addTokenToToAllTokenEnumration(tokenId);
            _addTokensToOwnerEnumeration(to, tokenId);
        }

    function _addTokenToToAllTokenEnumration(uint256 tokenId) private{
        _allTokenIndex[tokenId] = _allTokens.length;
        _allTokens.push(tokenId);
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private{
        
        _ownedTokens[to].push(tokenId);
        _ownedTokenIndex[tokenId] = _ownedTokens[to].length;

    }

  

    
}