# Matriz de Prioridade — VCardSmart

## Classificação de Prioridade

| Prioridade | Critério | Descrição |
|------------|----------|-----------|
| P0 | Crítica | Funcionalidade core, obrigatória |
| P1 | Alta | Importante, impacto significativo |
| P2 | Média | Desejável, melhoria de experiência |
| P3 | Baixa | Futuro, experimento, opcional |

## Matriz de Decisão

### Eixo 1: Impacto no Usuário

| Nível | Descrição |
|-------|-----------|
| Alto | Muda significativamente a experiência |
| Médio | Melhora a experiência |
| Baixo | Pequena melhoria |

### Eixo 2: Esforço de Implementação

| Nível | Descrição |
|-------|-----------|
| Alto | Muitas semanas de trabalho |
| Médio | Algumas semanas de trabalho |
| Baixo | Poucos dias de trabalho |

## Matriz Completa

### Alto Impacto, Baixo Esforço (P0)

| Funcionalidade | Impacto | Esforço | Prioridade |
|----------------|---------|---------|------------|
| Templates | Alto | Baixo | P0 |
| Histórico avançado | Alto | Baixo | P0 |
| Estatísticas locais | Alto | Baixo | P0 |

### Alto Impacto, Médio Esforço (P1)

| Funcionalidade | Impacto | Esforço | Prioridade |
|----------------|---------|---------|------------|
| Widget | Alto | Médio | P1 |
| Múltiplos cartões | Alto | Médio | P1 |
| Pastas | Alto | Médio | P1 |
| QR personalizado | Alto | Médio | P1 |

### Alto Impacto, Alto Esforço (P1/P2)

| Funcionalidade | Impacto | Esforço | Prioridade |
|----------------|---------|---------|------------|
| Compartilhamento por proximidade | Alto | Alto | P1 |
| Backup criptografado | Alto | Alto | P1 |
| Sincronização opcional | Alto | Alto | P2 |
| Apple Watch | Alto | Alto | P2 |
| Wear OS | Alto | Alto | P2 |

### Médio Impacto, Baixo Esforço (P2)

| Funcionalidade | Impacto | Esforço | Prioridade |
|----------------|---------|---------|------------|
| Favoritos | Médio | Baixo | P2 |
| Temas personalizados | Médio | Baixo | P2 |
| Exportações avançadas | Médio | Baixo | P2 |

### Médio Impacto, Médio Esforço (P2)

| Funcionalidade | Impacto | Esforço | Prioridade |
|----------------|---------|---------|------------|
| Organização por categorias | Médio | Médio | P2 |
| QR dinâmico | Médio | Médio | P2 |
| Compartilhamento programado | Médio | Médio | P2 |

### Médio Impacto, Alto Esforço (P3)

| Funcionalidade | Impacto | Esforço | Prioridade |
|----------------|---------|---------|------------|
| API pública | Médio | Alto | P3 |
| Portal Web | Médio | Alto | P3 |
| Dashboard | Médio | Alto | P3 |

### Baixo Impacto, Qualquer Esforço (P3)

| Funcionalidade | Impacto | Esforço | Prioridade |
|----------------|---------|---------|------------|
| Apple Vision Pro | Baixo | Alto | P3 |
| Android XR | Baixo | Alto | P3 |
| Desktop | Baixo | Alto | P3 |
| CarPlay | Baixo | Alto | P3 |
| Android Auto | Baixo | Alto | P3 |

## Regras de Priorização

### Sempre P0

1. Funcionalidades core
2. Segurança
3. Performance crítica
4. Bugs que quebram o app

### Sempre P1

1. Melhorias de usabilidade significativas
2. Funcionalidades muito solicitadas
3. Otimizações de performance importantes

### Normalmente P2

1. Funcionalidades desejáveis
2. Melhorias visuais
3. Expansões de plataforma

### Normalmente P3

1. Funcionalidades futuras
2. Experimentos
3. Plataformas emergentes

## Processo de Decisão

### Fluxo

```
Ideia
  ↓
Avaliação de Impacto
  ↓
Avaliação de Esforço
  ↓
Classificação na Matriz
  ↓
Definição de Prioridade
  ↓
Inclusão no Roadmap
```

### Critérios Adicionais

| Critério | Peso |
|----------|------|
| Alinhamento com visão | 25% |
| Potencial de monetização | 20% |
| Urgência | 15% |
| Dependências | 10% |

## Revisão

### Frequência

| Ação | Frequência |
|------|------------|
| Revisão do backlog | Semanal |
| Priorização | Quinzenal |
| Roadmap | Mensal |
| Estratégia | Trimestral |
