// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
    1.NFT 指向一個地址
    2.追蹤每個Token id
    3.追蹤每個持有者地址->token id //mapping
    4.track of how many tokens an owner address has
    5.create event去傳輸log-contract address, where it is being minted to, the id
    */
contract ERC721{
    //indexed can save gas
    event Transfer(
        address indexed from,
        address indexed to,
        uint indexed tokenId);

    //token id => owner
    mapping(uint256 => address) private _tokenOwner;
    //owner => number of ownde tokens
    mapping(address => uint256) private _OwndeTokensCount;
    
    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) public view returns(uint){
        require(_owner != address(0), 'owner can not be 0');
        return _OwndeTokensCount[_owner];
    }
    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint _tokenId) public view returns(address){
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), 'owner can not be 0');       
        return owner;
    }
    /* 
    _mint 有兩個參數 address(to), uint(tokenId)
    set internal to the signature
    set _tokienOwner of the tokenId to the address(to)
    increase the owner token count by 1 each time the function is called
    require mint address isn't 0
    require thoen has't already been minted
    */
    function _exists(uint tokenId) internal view returns(bool){
        address owner = _tokenOwner[tokenId];
        return owner != address(0);
    }
    function _mint(address to, uint256 tokenId) internal virtual{
        require(to != address(0),"mint address can't be 0!");
        require(!_exists(tokenId), "REC721: token already minted");
        _tokenOwner[tokenId] = to;
        _OwndeTokensCount[to] += 1;

        emit Transfer(address(0), to, tokenId);
    }
}