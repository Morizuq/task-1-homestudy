// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract VotingSystem{
    address public owner;
    //Associates a candidates name withir the number of votes
    mapping (string => uint256) public votes;
    string[] public candidates;

    constructor(string[] memory _candidates){
        owner = msg.sender;
        candidates = _candidates;
        for(uint256 i = 0; i < candidates.length; i++ ){
            votes[candidates[i]] = 0;
        }
    }

    modifier  onlyOwner(){
        require(msg.sender == owner, "Only the owner can carry out this action");
        _;
    }

    function vote(string memory candidate) public {
        require(bytes(candidate).length > 0, "Candidate name cannot be empty");
        // require(votes[candidate] !=0, "Invalid candidate");
        votes[candidate]++;
    }

    function getResult() public view returns (string[] memory, uint256[] memory ){
        uint256[] memory voteCounts = new uint256[](candidates.length);
        for(uint256 i = 0; i < candidates.length; i++){
            voteCounts[i] = votes[candidates[i]];
        }
        return (candidates, voteCounts);
    }

}