# Checklists de QA — VCardSmart

## 1. UI

- [ ] Layout consistente em todas as telas
- [ ] Cores do tema aplicadas corretamente
- [ ] Tipografia consistente
- [ ] Espaçamentos padronizados
- [ ] Ícones claros e consistentes
- [ ] Botões com tamanho adequado (≥48x48)
- [ ] Estados visuais (hover, pressed, disabled)
- [ ] Animações suaves
- [ ] Overflow evitado
- [ ] Responsividade em diferentes tamanhos

## 2. UX

- [ ] Fluxo intuitivo
- [ ] Feedback visual em ações
- [ ] Loading states adequados
- [ ] Mensagens de erro claras
- [ ] Validação em tempo real
- [ ] Desfazer/Repetir disponível
- [ ] Navegação consistente
- [ ] Acessibilidade por teclado
- [ ] Touch targets adequados
- [ ] Gestos intuitivos

## 3. Performance

- [ ] Inicialização < 2s
- [ ] Resposta a interações < 200ms
- [ ] Sem memory leaks
- [ ] FPS > 55
- [ ] Tamanho do app < 20MB
- [ ] Sem jank em scroll
- [ ] Imagens otimizadas
- [ ] Cache adequado
- [ ] Batch de operações
- [ ] Lazy loading

## 4. Segurança

- [ ] Biometria funcionando
- [ ] PIN validado com hash
- [ ] Hive criptografado
- [ ] Secure Storage não expõe dados
- [ ] Input sanitizado
- [ ] Permissões tratadas
- [ ] Timeout configurado
- [ ] Lock automático ativo
- [ ] Dados sensíveis limpos da memória
- [ ] Logs sem dados sensíveis

## 5. Offline

- [ ] App funciona sem internet
- [ ] Dados salvos localmente
- [ ] Sincronização automática
- [ ] Indicador de status offline
- [ ] Filas de operações
- [ ] Resolução de conflitos
- [ ] Cache de dados
- [ ] Retry automático
- [ ] Mensagens claras
- [ ] Dados preservados

## 6. QR Code

- [ ] Geração rápida (< 1s)
- [ ] Leitura precisa
- [ ] Compartilhamento como imagem
- [ ] Compartilhamento via apps
- [ ] QR Code nítido
- [ ] Tamanho adequado
- [ ] Contraste suficiente
- [ ] Tratamento de erro
- [ ] Fallback disponível
- [ ] Testado em diferentes条件

## 7. NFC

- [ ] Leitura confiável
- [ ] Escrita confiável
- [ ] Tratamento de timeout
- [ ] Dados formatados corretamente
- [ ] Compatibilidade com devices
- [ ] Fallback para QR
- [ ] Mensagens de status
- [ ] Permissões verificadas
- [ ] Dados validados
- [ ] Segurança nos dados

## 8. vCard

- [ ] Geração válida (RFC 6350)
- [ ] Importação funciona
- [ ] Exportação funciona
- [ ] Campos opcionais suportados
- [ ] Caracteres especiais tratados
- [ ] Unicode suportado
- [ ] Tamanho adequado
- [ ] Compatibilidade
- [ ] Validação de entrada
- [ ] Tratamento de erro

## 9. Internacionalização

- [ ] Todos os strings traduzidos
- [ ] Sem strings hardcoded
- [ ] Formatação de datas correta
- [ ] Formatação de números correta
- [ ] Layout para textos longos
- [ ] RTL suportado (se necessário)
- [ ] Troca de idioma dinâmica
- [ ] Persistência de preferência
- [ ] Fallback para inglês
- [ ] Testado em todos os idiomas

## 10. Acessibilidade

- [ ] Labels semânticos
- [ ] Contraste ≥ 4.5:1
- [ ] Foco visível
- [ ] Navegação por teclado
- [ ] Touch targets ≥ 48x48
- [ ] Fonte escala até 200%
- [ ] Estados anunciados
- [ ] Erros anunciados
- [ ] Modais trapam foco
- [ ] Sem dependência de cor

## Execução

```bash
# Verificar UI
flutter analyze

# Verificar performance
flutter test --profile

# Verificar acessibilidade
flutter test test/accessibility/

# Verificar i18n
flutter test test/i18n/
```
