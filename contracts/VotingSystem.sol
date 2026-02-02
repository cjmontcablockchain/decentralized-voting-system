//Licencia
//   SPDX-License-Identifier: LGPL-3.0-only
//Version solidity
pragma solidity 0.8.24;

contract VotingSystem {
    
    struct Proposal {
        uint256 id;
        string title;
        string description;
        address proposer;
        uint256 forVotes;
        uint256 againstVotes;
        uint256 startTime;
        uint256 endTime;
        bool executed;
        mapping(address => bool) hasVoted;
    }
    
    uint256 public proposalCount;
    mapping(uint256 => Proposal) public proposals;
    
    // Parámetros configurables
    uint256 public votingPeriod = 3 days;
    
    // Eventos
    event ProposalCreated(
        uint256 indexed proposalId,
        address indexed proposer,
        string title,
        uint256 startTime,
        uint256 endTime
    );
    
    event VoteCast(
        uint256 indexed proposalId,
        address indexed voter,
        bool support
    );
    
    event ProposalExecuted(uint256 indexed proposalId, bool passed);
    
    // Crear propuesta
    function createProposal(
        string memory _title,
        string memory _description
    ) external returns (uint256) {
        
        uint256 proposalId = proposalCount++;
        Proposal storage newProposal = proposals[proposalId];
        
        newProposal.id = proposalId;
        newProposal.title = _title;
        newProposal.description = _description;
        newProposal.proposer = msg.sender;
        newProposal.startTime = block.timestamp;
        newProposal.endTime = block.timestamp + votingPeriod;
        newProposal.executed = false;
        
        emit ProposalCreated(
            proposalId,
            msg.sender,
            _title,
            newProposal.startTime,
            newProposal.endTime
        );
        
        return proposalId;
    }
    
    // Votar en una propuesta
    function vote(uint256 _proposalId, bool _support) external {
        Proposal storage proposal = proposals[_proposalId];
        
        require(block.timestamp >= proposal.startTime, "Voting not started");
        require(block.timestamp <= proposal.endTime, "Voting ended");
        require(!proposal.hasVoted[msg.sender], "Already voted");
        
        proposal.hasVoted[msg.sender] = true;
        
        if (_support) {
            proposal.forVotes++;
        } else {
            proposal.againstVotes++;
        }
        
        emit VoteCast(_proposalId, msg.sender, _support);
    }
    
    // Ejecutar propuesta (solo después de que termine la votación)
    function executeProposal(uint256 _proposalId) external {
        Proposal storage proposal = proposals[_proposalId];
        
        require(block.timestamp > proposal.endTime, "Voting still active");
        require(!proposal.executed, "Already executed");
        
        proposal.executed = true;
        bool passed = proposal.forVotes > proposal.againstVotes;
        
        emit ProposalExecuted(_proposalId, passed);
    }
    
    // Obtener información de una propuesta
    function getProposal(uint256 _proposalId) external view returns (
        uint256 id,
        string memory title,
        string memory description,
        address proposer,
        uint256 forVotes,
        uint256 againstVotes,
        uint256 startTime,
        uint256 endTime,
        bool executed
    ) {
        Proposal storage proposal = proposals[_proposalId];
        return (
            proposal.id,
            proposal.title,
            proposal.description,
            proposal.proposer,
            proposal.forVotes,
            proposal.againstVotes,
            proposal.startTime,
            proposal.endTime,
            proposal.executed
        );
    }
    
    // Verificar si un usuario ha votado
    function hasVoted(uint256 _proposalId, address _voter) external view returns (bool) {
        return proposals[_proposalId].hasVoted[_voter];
    }
    
    // Obtener estado de la votación
    function getVotingStatus(uint256 _proposalId) external view returns (
        bool isActive,
        bool hasPassed,
        uint256 totalVotes
    ) {
        Proposal storage proposal = proposals[_proposalId];
        
        isActive = block.timestamp >= proposal.startTime && 
                   block.timestamp <= proposal.endTime;
        
        totalVotes = proposal.forVotes + proposal.againstVotes;
        hasPassed = proposal.forVotes > proposal.againstVotes;
        
        return (isActive, hasPassed, totalVotes);
    }
    
    // Obtener todas las propuestas (útil para el frontend)
    function getAllProposalsCount() external view returns (uint256) {
        return proposalCount;
    }
    
    // Cambiar el periodo de votación (solo para testing)
    function setVotingPeriod(uint256 _newPeriod) external {
        votingPeriod = _newPeriod;
    }
}