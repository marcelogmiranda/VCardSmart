# Non-Functional Requirements

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## 1. Performance

| ID | Requisito | Métrica | Status |
|----|-----------|---------|--------|
| RNF001 | Tempo de inicialização | ≤ 2 segundos (dispositivos compatíveis) | A validar |
| RNF002 | Tempo de compartilhamento NFC | ≤ 5 segundos | A validar |
| RNF003 | Tempo de geração de QR | ≤ 1 segundo | A validar |
| RNF004 | Tempo de leitura de QR | ≤ 3 segundos | A validar |
| RNF005 | Taxa de frames da interface | ≥ 60 FPS (quando suportado) | A validar |
| RNF006 | Tempo de troca de tema | < 500ms | A validar |
| RNF007 | Tempo de troca de idioma | < 500ms | A validar |
| RNF008 | Tempo de abertura de tela | < 300ms | A validar |

---

## 2. Segurança

| ID | Requisito | Descrição |
|----|-----------|-----------|
| RNF010 | Criptografia local | Dados sensíveis criptografados no Hive |
| RNF011 | Biometria via APIs oficiais | Utilizar somente APIs do sistema |
| RNF012 | Sem transmissão de dados | Nenhuma comunicação com servidores |
| RNF013 | Sem armazenamento em nuvem | Dados exclusivamente no dispositivo |
| RNF014 | Sem analytics | Nenhum dado de uso coletado |
| RNF015 | Sem rastreamento | Nenhum tracking implementado |
| RNF016 | Limpeza ao desinstalar | Todos os dados removidos |

---

## 3. Compatibilidade

| ID | Requisito | Especificação |
|----|-----------|---------------|
| RNF020 | Android mínimo | Android 6.0 (API 23) |
| RNF021 | iOS mínimo | iOS 13.0 |
| RNF022 | Flutter mínimo | Versão estável atual |
| RNF023 | NFC | Disponível na maioria dos dispositivos modernos |
| RNF024 | Câmera | Necessária para QR Code |
| RNF025 | Biometria | Opcional, degrada gracefulmente |
| RNF026 | Resolução mínima | 320x480 pixels |

---

## 4. Offline

| ID | Requisito | Descrição |
|----|-----------|-----------|
| RNF030 | 100% offline | Todas as funcionalidades sem internet |
| RNF031 | Sem sincronização | Nenhum dado é sincronizado |
| RNF032 | Sem backup em nuvem | Backup local apenas (futuro) |
| RNF033 | Sem atualização automática de dados | Dados estáticos no dispositivo |

---

## 5. Escalabilidade

| ID | Requisito | Descrição |
|----|-----------|-----------|
| RNF040 | Múltiplos cartões (V2) | Arquitetura preparada para futura expansão |
| RNF041 | Premium (V3) | Sistema de features preparado |
| RNF042 | Empresa (V4) | Estrutura preparada para gestão corporativa |
| RNF043 | Cloud opcional (V5) | Camada de dados preparada para extensão |

---

## 6. Internacionalização

| ID | Requisito | Descrição |
|----|-----------|-----------|
| RNF050 | 8 idiomas | PT, EN, ES, FR, IT, DE, JA, ZH |
| RNF051 | ARB | Todas as strings em arquivos ARB |
| RNF052 | Sem strings fixas | Nenhum texto hard-coded |
| RNF053 | Troca dinâmica | Mudança de idioma sem reiniciar |
| RNF054 | Idioma do sistema | Detectar e seguir preferência |

---

## 7. Design

| ID | Requisito | Descrição |
|----|-----------|-----------|
| RNF060 | Material Design 3 | Seguir diretrizes do Material Design |
| RNF061 | Temas | Suporte a claro, escuro e sistema |
| RNF062 | Animações | Transições suaves entre telas |
| RNF063 | Responsividade | Adaptar-se a diferentes tamanhos de tela |
| RNF064 | Ícones | Utilizar ícones Material Design |

---

## 8. Biometria

| ID | Requisito | Descrição |
|----|-----------|-----------|
| RNF070 | Face ID | Utilizar quando disponível (iOS) |
| RNF071 | Impressão digital | Utilizar quando disponível (Android/iOS) |
| RNF072 | PIN fallback | Quando biometria indisponível |
| RNF073 | Sem dados biométricos | Nunca armazenar dados biométricos |

---

## 9. Acessibilidade

| ID | Requisito | Descrição |
|----|-----------|-----------|
| RNF080 | Fonte dinâmica | Suportar tamanho de fonte do sistema |
| RNF081 | Leitor de tela | Labels em todos os componentes interativos |
| RNF082 | Contraste | WCAG 2.1 AA (4.5:1 para texto normal) |
| RNF083 | Touch mínimo | Alvos de toque ≥ 48x48 dp |
| RNF084 | Sem dependência de cores | Informações não transmitidas apenas por cor |

---

## 10. Qualidade

| ID | Requisito | Descrição |
|----|-----------|-----------|
| RNF090 | Flutter analyze | Zero erros |
| RNF091 | dart format | Código formatado |
| RNF092 | Testes unitários | Cobertura mínima de 70% |
| RNF093 | Testes de widget | Cobertura de widgets principais |
| RNF094 | Testes de integração | Fluxos críticos cobertos |
| RNF095 | Crash-free rate | ≥ 99.5% |

---

## 11. Manutenibilidade

| ID | Requisito | Descrição |
|----|-----------|-----------|
| RNF100 | Clean Architecture | Seguir estrutura de camadas |
| RNF101 | SOLID | Princípios de design orientado a objeto |
| RNF102 | Documentação | Código documentado quando necessário |
| RNF103 | Changelog | Registro de alterações funcionais |

---

## Documentos Relacionados

- [09_FunctionalRequirements.md](./09_FunctionalRequirements.md)
- [11_AcceptanceCriteria.md](./11_AcceptanceCriteria.md)
- [16_Accessibility.md](./16_Accessibility.md)
