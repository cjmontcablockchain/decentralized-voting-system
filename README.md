# Decentralized Voting System

Sistema de votación descentralizado implementado en Solidity para gobernanza on-chain.

![Solidity](https://img.shields.io/badge/Solidity-^0.8.20-363636?style=for-the-badge&logo=solidity)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)
![Remix](https://img.shields.io/badge/Remix-IDE-blue?style=for-the-badge)

## 📋 Descripción

Sistema de votación que permite a los usuarios crear propuestas y votar de forma descentralizada. Implementa un modelo democrático de 1 dirección = 1 voto con períodos de votación limitados y prevención de doble voto.

## ✨ Características

- Creación de propuestas por cualquier usuario
- Sistema de votación: 1 dirección = 1 voto
- Periodo de votación configurable (default: 3 días)
- Prevención de doble voto mediante mapping
- Eventos para tracking de actividad on-chain
- Consultas de estado en tiempo real
- Ejecución de propuestas tras finalización del periodo

## 🛠️ Tecnologías

- **Solidity**: ^0.8.20
- **Remix IDE**: Desarrollo y testing

## 🚀 Uso

### Desplegar el contrato

1. Abrir `contracts/VotingSystem.sol` en Remix
2. Compilar con CTRL + S
3. Ir a Deploy & Run Transactions
4. Seleccionar entorno: Remix VM (Shanghai)
5. Click en Deploy

### Crear una propuesta

```solidity
createProposal(
    "Aumentar presupuesto desarrollo",
    "Propuesta para incrementar el presupuesto en un 20%"
)
```

### Votar

```solidity
// Votar a favor
vote(0, true)

// Votar en contra
vote(0, false)
```

### Consultar resultados

```solidity
// Información completa de la propuesta
getProposal(0)

// Estado actual de la votación
getVotingStatus(0)

// Verificar si una dirección ha votado
hasVoted(0, "0x...")
```

## 📝 Funciones principales

| Función | Descripción |
|---------|-------------|
| `createProposal` | Crea una nueva propuesta |
| `vote` | Emite un voto a favor o en contra |
| `executeProposal` | Marca propuesta como ejecutada tras fin de periodo |
| `getProposal` | Obtiene detalles de una propuesta |
| `getVotingStatus` | Retorna estado actual de la votación |
| `hasVoted` | Verifica si una dirección ya votó |
| `getAllProposalsCount` | Retorna el total de propuestas creadas |
| `setVotingPeriod` | Modifica el periodo de votación (testing) |

## 🧪 Testing

### Tests automatizados

1. Activar plugin "Solidity unit testing" en Remix
2. Seleccionar `tests/VotingSystem.test.sol`
3. Click en Run

### Escenarios de prueba manuales

Ver documentación detallada en `scripts/test_scenarios.md`

## 📊 Estructura del Proyecto

```
decentralized-voting-system/
├── contracts/              # Smart contracts
│   └── VotingSystem.sol
├── tests/                  # Tests automatizados
│   └── VotingSystem.test.sol
├── scripts/                # Documentación de pruebas
│   └── test_scenarios.md
├── .gitignore
├── LICENSE
└── README.md
```

## 🔐 Seguridad

- Prevención de doble voto mediante mapping por dirección
- Validación temporal con `block.timestamp` para controlar el periodo
- Flag `executed` para evitar re-ejecución de propuestas
- Require statements en todas las funciones críticas

## 🚧 Mejoras futuras

- Implementar votación ponderada por tokens ERC20
- Añadir quorum mínimo para validar propuestas
- Sistema de delegación de votos
- Timelock para ejecución de propuestas
- Frontend con React y Web3.js
- Deploy en testnet (Sepolia)

## 👤 Autor

**Carlos**

- 🎓 Máster en Blockchain - CodeCrypto Academy (2024-2025)
- 💼 Team Lead Developer en Indra
- 📍 San Fernando, Cádiz, España

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver [LICENSE](LICENSE) para detalles.
```

Pégalo en tu README.md y cuando esté listo nos preparamos para subir todo a GitHub.