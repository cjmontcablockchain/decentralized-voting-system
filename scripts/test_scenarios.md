 Escenarios de Prueba - VotingSystem

## Caso 1: Flujo completo de votación
**Pasos:**
1. Deploy del contrato
2. Crear propuesta con cuenta A
3. Votar a favor con cuenta B
4. Votar en contra con cuenta C
5. Verificar resultados

**Resultado esperado:**
- Propuesta creada con ID 0
- 1 voto a favor
- 1 voto en contra
- Estado: Activa

## Caso 2: Prevención de doble voto
**Pasos:**
1. Crear propuesta
2. Votar con cuenta A
3. Intentar votar nuevamente con cuenta A

**Resultado esperado:**
- Error: "Already voted"

## Caso 3: Votación fuera de periodo
**Pasos:**
1. Crear propuesta
2. Esperar que termine el periodo (usar setVotingPeriod para acortar)
3. Intentar votar

**Resultado esperado:**
- Error: "Voting ended"

## Caso 4: Ejecución de propuesta
**Pasos:**
1. Crear propuesta
2. Esperar fin de periodo
3. Ejecutar propuesta
4. Verificar que no se puede ejecutar dos veces

**Resultado esperado:**
- Propuesta ejecutada correctamente
- Error al intentar ejecutar nuevamente: "Already executed"