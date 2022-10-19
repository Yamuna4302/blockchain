
pragma solidity >=0.7.0 <0.9.0;
contract Ballot {
 
  
  mapping (string => uint256) private votesReceived;
  address public chairperson;

  string[] private candidateList;


  constructor(string[] memory candidateNames) {
      chairperson = msg.sender;
      candidateList = candidateNames;
  }

  modifier onlyChair() {
         require(msg.sender == chairperson, 'Only chairperson');
         _;
    }
    
    function addcanditate(string memory name) public onlyChair{
    candidateList.push(name);
  }

  function totalVotesFor(string memory candidate) view public onlyChair returns (uint256)  {

    require(validCandidate(candidate));
    return votesReceived[candidate];
  }

 
  function castVote(string memory candidate) public {
    require(validCandidate(candidate));
    votesReceived[candidate] += 1;
  }

  function validCandidate(string memory candidate) view private returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
      if (keccak256(bytes(candidateList[i])) == keccak256(bytes(candidate))) {
        return true;
      }
    }
    return false;
  }
}