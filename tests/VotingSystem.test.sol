//Licencia
//   SPDX-License-Identifier: LGPL-3.0-only
//Version solidity
pragma solidity 0.8.24;

import "remix_tests.sol";
import "../contracts/VotingSystem.sol";

contract VotingSystemTest {
    VotingSystem votingSystem;
    
    // Se ejecuta antes de cada test
    function beforeEach() public {
        votingSystem = new VotingSystem();
        // Reducir periodo de votación para testing
        votingSystem.setVotingPeriod(60); // 60 segundos
    }
    
    /// Test: Crear propuesta exitosamente
    function testCreateProposal() public {
        uint256 proposalId = votingSystem.createProposal(
            "Test Proposal",
            "This is a test"
        );
        
        Assert.equal(proposalId, 0, "First proposal should have ID 0");
        Assert.equal(votingSystem.proposalCount(), 1, "Should have 1 proposal");
    }
    
    /// Test: Votar a favor
    function testVoteFor() public {
        votingSystem.createProposal("Test", "Description");
        
        votingSystem.vote(0, true);
        
        (,,,, uint256 forVotes,,,,) = votingSystem.getProposal(0);
        Assert.equal(forVotes, 1, "Should have 1 vote for");
    }
    
    /// Test: Verificar prevención de doble voto
    /// #value: 0
    function testPreventDoubleVote() public {
        votingSystem.createProposal("Test", "Description");
        
        votingSystem.vote(0, true);
        
        // Intentar votar de nuevo debería fallar
        try votingSystem.vote(0, true) {
            Assert.ok(false, "Should not allow double voting");
        } catch Error(string memory reason) {
            Assert.equal(reason, "Already voted", "Should return already voted error");
        }
    }
    
    /// Test: Obtener estado de votación
    function testGetVotingStatus() public {
        votingSystem.createProposal("Test", "Description");
        
        (bool isActive, bool hasPassed, uint256 totalVotes) = votingSystem.getVotingStatus(0);
        
        Assert.equal(isActive, true, "Proposal should be active");
        Assert.equal(hasPassed, false, "Should not have passed yet");
        Assert.equal(totalVotes, 0, "Should have 0 votes");
    }
    
    /// Test: Verificar contador de propuestas
    function testProposalCount() public {
        Assert.equal(votingSystem.getAllProposalsCount(), 0, "Should start with 0 proposals");
        
        votingSystem.createProposal("First", "Description");
        Assert.equal(votingSystem.getAllProposalsCount(), 1, "Should have 1 proposal");
        
        votingSystem.createProposal("Second", "Description");
        Assert.equal(votingSystem.getAllProposalsCount(), 2, "Should have 2 proposals");
    }
}