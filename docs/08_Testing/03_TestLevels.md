# Níveis de Teste — VCardSmart

## Visão Geral

```
┌─────────────────────────────────────────┐
│           End-to-End (E2E)              │  ← Fluxos completos
├─────────────────────────────────────────┤
│          Integration Tests              │  ← Integração entre módulos
├─────────────────────────────────────────┤
│           Golden Tests                  │  ← Comparação visual
├─────────────────────────────────────────┤
│           Widget Tests                  │  ← Componentes UI
├─────────────────────────────────────────┤
│            Unit Tests                   │  ← Lógica isolada
└─────────────────────────────────────────┘
```

## 1. Unit Tests

### O que testa
- UseCases (regras de negócio)
- Repositories (acesso a dados)
- Services (serviços auxiliares)
- Mappers (transformação de dados)
- Validators (validações)
- ValueObjects (objetos de valor)

### Cobertura
- **Meta**: 100% dos UseCases
- **Escopo**: Lógica pura, sem dependência de UI
- **Velocidade**: < 1ms por teste

### Estrutura
```
test/unit/
├── application/
│   ├── usecases/
│   └── services/
├── domain/
│   ├── entities/
│   ├── value_objects/
│   └── validators/
└── data/
    ├── repositories/
    ├── services/
    └── mappers/
```

## 2. Widget Tests

### O que testa
- Renderização de componentes
- Estados da UI (Loading, Erro, Vazio, Sucesso)
- Interações do usuário
- Navegação

### Cobertura
- **Meta**: 100% das telas
- **Escopo**: Componentes isolados com mocks
- **Velocidade**: < 100ms por teste

### Estrutura
```
test/widget/
├── screens/
│   ├── profile/
│   ├── qrcode/
│   ├── nfc/
│   └── settings/
└── components/
    ├── buttons/
    ├── inputs/
    └── dialogs/
```

## 3. Integration Tests

### O que testa
- Fluxos entre módulos
- Integração com APIs nativas
- Circuitos de dados completos

### Cobertura
- **Meta**: 100% dos fluxos críticos
- **Escopo**: Múltiplos módulos trabalhando juntos
- **Velocidade**: < 1s por teste

### Estrutura
```
test/integration/
├── profile_flow_test.dart
├── qrcode_flow_test.dart
├── nfc_flow_test.dart
├── vcard_flow_test.dart
├── settings_flow_test.dart
└── offline_flow_test.dart
```

## 4. Golden Tests

### O que testa
- Comparação visual de componentes
- Regressão visual
- Consistência entre temas

### Cobertura
- **Meta**: 100% dos componentes
- **Escopo**: Tema claro, escuro, acessibilidade
- **Velocidade**: < 500ms por teste

### Estrutura
```
test/golden/
├── components/
├── screens/
└── golden_files/
```

## 5. End-to-End Tests

### O que testa
- Fluxos completos do usuário
- Interações reais com o dispositivo
- Caminhos críticos do negócio

### Cobertura
- **Meta**: 100% dos fluxos críticos
- **Escopo**: App completo em device real/emulador
- **Velocidade**: < 30s por teste

### Estrutura
```
test/integration/
├── e2e/
│   ├── first_use_test.dart
│   ├── create_profile_test.dart
│   ├── share_qrcode_test.dart
│   └── settings_test.dart
└── ...
```

## 6. Performance Tests

### O que testa
- Tempo de inicialização
- Tempo de resposta de funcionalidades
- Uso de memória e CPU
- FPS e fluidez

### Métricas
| Métrica | Meta |
|---------|------|
| Inicialização | < 2s |
| QR Code scan | < 1s |
| NFC leitura | < 5s |
| Memória | < 100MB |
| CPU | < 30% |
| FPS | > 55 |

## 7. Security Tests

### O que testa
- Autenticação (biometria/PIN)
- Criptografia de dados
- Validação de input
- Permissões
- Timeout e lock

### Cenários
- Tentativas inválidas de PIN
- Bypass de autenticação
- Acesso não autorizado a dados
- Injeção de código malicioso

## 8. Accessibility Tests

### O que testa
- TalkBack (Android)
- VoiceOver (iOS)
- Escala de fonte
- Contraste
- Navegação por teclado
- Foco

### Padrões
- WCAG 2.1 AA
- Material Design Accessibility
- Apple HIG Accessibility

## 9. Internationalization Tests

### O que testa
- Tradução de strings
- Formatação de datas/números
- Layout com textos longos
- RTL (se necessário)

### Idiomas
- pt (Português) — Padrão
- en (Inglês)
- es (Espanhol)
- fr (Francês)
- it (Italiano)
- de (Alemão)
- ja (Japonês)
- zh (Chinês)

## Matriz de Decisão

| Tipo | Quando Executar | Automação | Prioridade |
|------|-----------------|-----------|------------|
| Unit | A cada commit | ✅ 100% | Alta |
| Widget | A cada commit | ✅ 100% | Alta |
| Integration | A cada PR | ✅ 90% | Alta |
| Golden | A cada PR | ✅ 100% | Média |
| E2E | Diário | ⚠️ 70% | Alta |
| Performance | Semanal | ✅ 80% | Média |
| Security | Pré-release | ✅ 90% | Crítica |
| Accessibility | Pré-release | ⚠️ 50% | Média |
| i18n | Pré-release | ✅ 80% | Média |
