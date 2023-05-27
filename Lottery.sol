// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.7;

contract Lottery{

    address public manager;
    address payable[] public participants;

    constructor(){
        manager = msg.sender; // 503935 gas
    }


    receive() external payable{
        require(msg.value == 1 ether,"You are not tranferring sufficient amount ");
        participants.push(payable(msg.sender));

    }

    function getBalance() public  view returns(uint) {
        require(msg.sender==manager);
        return address(this).balance;

    }

    function selectRandomParticipant() public  view returns (address) {
        require(msg.sender==manager);
        require(participants.length>=3);
        uint256 randomIndex = uint256(keccak256(abi.encodePacked(block.timestamp, block.difficulty))) % participants.length;
        return participants[randomIndex];
  }
   

    function getlength() public view  returns(uint) {
        return participants.length;

    }    


}