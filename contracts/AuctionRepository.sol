// // SPDX-License-Identifier: MIT
// pragma solidity >=0.4.22 <0.9.0;

// contract AuctionRepository {
//   constructor() public {
//   }
// }


pragma solidity 0.8.11;

import { Auction } from './Auction.sol';

contract AuctionFactory {
    address[] auctions;
    mapping(address => address[]) active_auctions; // asset_address =&gt; auctions[]
    mapping(address => address[]) complete_auctions; // asset_address =&gt; auctions[]

    event AuctionCreated(address auctionContract, address owner, uint numAuctions, address[] allAuctions);

    address crosAccount;

    modifier onlyCrosAccout {
        require(msg.sender == crosAccount);
        _;
    }

    constructor(address cros_account) public {
            crosAccount =cros_account;
    }

    function initialize(address cros_account) public  {
      crosAccount =cros_account;
  }

    // function createAuction(uint bidIncrement, uint startBlock, uint endBlock)  external {
    //     Copy_NewAuction  newAuction = new Copy_NewAuction(msg.sender, bidIncrement, startBlock, endBlock);
    //     auctions.push(newAuction);

    //     AuctionCreated(newAuction, msg.sender, auctions.length, auctions);
    // }


    function allAuctions() external view returns (address[] memory) {
        return auctions;
    }

    function publish(address asset, uint256 createdDate, uint256 startTime, uint256 endTime) external returns(address) {
        Auction  newAuction = new Auction(asset, createdDate, startTime, endTime);
        auctions.push(address(newAuction));
        active_auctions[asset].push(address(newAuction));
        return address(newAuction);
    }


}
/*

  constructor(address _asset, uint256 createdDate, uint256 _startTime, uint256 _endTime) public {
        if (startTime >= endTime) revert("start time should be greater then end time");
        if (startTime < block.number) revert("start time is greater then block.numner");
        if (asset == address(0)) revert();

        owner = msg.sender;
        asset = _asset;
        startBlock = _startTime;
        endBlock = _endTime;

    }

- function publish(address asset, uint256 createdDate, uint256 startTime, uint256
endTime) public returns (address auction);
5. - function auctions(bool active, bool complete) public return (mapping(address =&gt;
address[]) auctions);
6. - function auction(address auction) public return (mapping(address =&gt; address[])
auctions);



*/