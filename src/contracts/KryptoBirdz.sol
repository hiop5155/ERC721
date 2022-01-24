// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import './ERC721Connector.sol';

contract Kryptobird is ERC721Connector{
    
    //array to store NFTs
    string[] public kryptoBird;
    
    mapping(string => bool) _kryptoBirdzExists;

    function mint(string memory _kryptoBird) public{
        
        require(!_kryptoBirdzExists[_kryptoBird], 'Error-already exists');

        kryptoBird.push(_kryptoBird);
        uint _id = kryptoBird.length -1;
        _mint(msg.sender, _id);
        _kryptoBirdzExists[_kryptoBird] = true;
    }
    constructor() ERC721Connector('KryptoBird', 'KBIRDZ'){
        
    }
}
