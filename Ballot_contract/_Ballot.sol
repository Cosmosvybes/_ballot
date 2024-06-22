// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.2;

contract ballotContract {
    struct Voter {
        string name;
        bool hasVoted;
    }
    struct Participant {
        string name;
        uint256 votes;
    }
    mapping(uint256 => Participant) public participants;

    mapping(string => Voter) votes;

    modifier hasNotVoted(string memory voter) {
        require(!votes[voter].hasVoted, "Sorry you can not voted twice");
        _;
    }

    function vote(string memory name, uint256 participant_id)
        public
        hasNotVoted(name)
        returns (string memory)
    {
        participants[participant_id].votes += 1;
        votes[name] = Voter(name, true);
        return "voted , thnaks";
    }

    address internal owner;

    constructor() {
        owner == msg.sender;
    }

    modifier isAdmin() {
        require(msg.sender == owner);
        _;
    }

    function createParticipant(uint256 user_id, string memory name)
        public
        isAdmin
    {
        participants[user_id] = Participant(name, 0);
    }
}
