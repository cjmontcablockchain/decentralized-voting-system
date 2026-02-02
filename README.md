# Decentralized Voting System

Decentralized voting system implemented in Solidity for on-chain governance.

![Solidity](https://img.shields.io/badge/Solidity-^0.8.20-363636?style=for-the-badge&logo=solidity)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Remix](https://img.shields.io/badge/Remix-IDE-blue?style=for-the-badge)

## 📋 Description

Voting system that allows users to create proposals and vote in a decentralized manner. Implements a democratic model of 1 address = 1 vote with limited voting periods and double-vote prevention.

## ✨ Features

- Proposal creation by any user
- Voting system: 1 address = 1 vote
- Configurable voting period (default: 3 days)
- Double-vote prevention through mapping
- Events for on-chain activity tracking
- Real-time status queries
- Proposal execution after period completion

## 🛠️ Technologies

- **Solidity**: ^0.8.20
- **Remix IDE**: Development and testing

## 🚀 Usage

### Deploy the contract

1. Open `contracts/VotingSystem.sol` in Remix
2. Compile with CTRL + S
3. Go to Deploy & Run Transactions
4. Select environment: Remix VM (Shanghai)
5. Click Deploy

### Create a proposal
```solidity
createProposal(
    "Increase development budget",
    "Proposal to increase the budget by 20%"
)
```

### Vote
```solidity
// Vote in favor
vote(0, true)

// Vote against
vote(0, false)
```

### Query results
```solidity
// Complete proposal information
getProposal(0)

// Current voting status
getVotingStatus(0)

// Check if an address has voted
hasVoted(0, "0x...")
```

## 📝 Main Functions

| Function | Description |
|---------|-------------|
| `createProposal` | Creates a new proposal |
| `vote` | Casts a vote in favor or against |
| `executeProposal` | Marks proposal as executed after period ends |
| `getProposal` | Gets details of a proposal |
| `getVotingStatus` | Returns current voting status |
| `hasVoted` | Checks if an address has already voted |
| `getAllProposalsCount` | Returns total number of proposals created |
| `setVotingPeriod` | Modifies voting period (for testing) |

## 🧪 Testing

### Automated tests

1. Enable "Solidity unit testing" plugin in Remix
2. Select `tests/VotingSystem.test.sol`
3. Click Run

### Manual test scenarios

See detailed documentation in `scripts/test_scenarios.md`

## 📊 Project Structure
```
decentralized-voting-system/
├── contracts/              # Smart contracts
│   └── VotingSystem.sol
├── tests/                  # Automated tests
│   └── VotingSystem.test.sol
├── scripts/                # Test documentation
│   └── test_scenarios.md
├── .gitignore
├── LICENSE
└── README.md
```

## 🔐 Security

- Double-vote prevention through address mapping
- Temporal validation with `block.timestamp` to control the period
- `executed` flag to prevent proposal re-execution
- Require statements in all critical functions

## 🚧 Future Improvements

- Implement token-weighted voting with ERC20
- Add minimum quorum to validate proposals
- Vote delegation system
- Timelock for proposal execution
- Frontend with React and Web3.js
- Deploy to testnet (Sepolia)

## 👤 Author

**Carlos**

- 💼 Backend Software Engineer at Indra
- 📍 San Fernando, Cádiz, Spain

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.
