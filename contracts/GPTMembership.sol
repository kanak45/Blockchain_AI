// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

import "@openzepplein/contracts/token/ERC21.sol";

contract GPTMembership is ERC721{
    address public owner;
    uint256 public membershipTypes;
    uint256 public totalMemberships;

    string public MY_CONTRACT = "kanak pANDEY"

     struct membership{
        uint256 id;
        string name;
        uint256 cost;
        string date;
     }

     struct UserMembership{
        uint256 id;
        uint256 membershipId;
        address addressUser;
        uint256 cost;
        string expireDate;
     }

     mapping(address => UserMembership) userMemberships;
     mapping(uint256 => Membership) memberships;
     mapping(uint256 => mapping(address => bool)) public hasBought;
     mapping(uint256 => mapping(uint256 => address)) public membershipTaken;
     mapping(uint256 => uint256[]) membershipTaken;

     modifier onlyOwner(){
        require(msg.sender == owner, "Only owner can call this function");

     }

     constructor(
        string memory _name, string memory _symbol
     )ERC721(_name,_symbol){
        owner = msg.sender;
     }

     function list(string memory _name,uint256 _cost, string memory _date) public onlyOwner(){
        membershipTypes++;
        membership[membershipTypes] = Membership(
        _name,
        _cost,
        _date
        );

     }

     function mint(uint256 _membershipId, address _user, string memory _expiredDate)
     public payable{
        require(_membershipId != 0);
        require(_membershipId<= membershipTypes);

        require(msg.value>= memberships[_membershipId].cost, "Insufficient balance");
        totalMemberships++;
        userMemberships[_user] = UserMembership(
            totalMemberships,
            _membershipId,
            _user,
            memberships[_membershipId].cost,
            _expiredDate
         );
         hasBought[_membershipId] [msg.sender] = true;
         membershipsTaken[_membershipId] [totalMemberships] = msg.sender;

         membershipsTaken[_membershipId].push(totalMemberships);
     }
}

