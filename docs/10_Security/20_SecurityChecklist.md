# Checklist de Segurança — VCardSmart

## Armazenamento

- [ ] Hive criptografado com AES-256
- [ ] Chaves em Flutter Secure Storage
- [ ] PIN hash em Secure Storage
- [ ] Dados sensíveis criptografados
- [ ] Sem dados em texto plano

## Autenticação

- [ ] Biometria disponível
- [ ] PIN configurável (4-8 dígitos)
- [ ] Tentativas limitadas (5)
- [ ] Timeout de bloqueio (5 min)
- [ ] Fallback para PIN

## Permissões

- [ ] Câmera: Obrigatória (QR Code)
- [ ] NFC: Opcional
- [ ] Contatos: Opcional
- [ ] Biometria: Opcional
- [ ] Internet: Obrigatória (Ads)

## Dados

- [ ] Sem analytics
- [ ] Sem Firebase
- [ ] Sem backend
- [ ] Sem cloud
- [ ] Sem logs sensíveis

## Compartilhamento

- [ ] Confirmação obrigatória
- [ ] Resumo antes de enviar
- [ ] Validação de dados
- [ ] Sanitização de input
- [ ] Limites de tamanho

## QR Code

- [ ] Validação de formato
- [ ] Checksum verificado
- [ ] Tamanho máximo (4KB)
- [ ] Sem execução de código
- [ ] Sanitização de dados

## NFC

- [ ] Validação de payload
- [ ] Versionamento
- [ ] Confirmação antes de salvar
- [ ] Cancelamento permitido
- [ ] Sem execução automática

## vCard

- [ ] Validação RFC 6350
- [ ] Campos conhecidos apenas
- [ ] Sanitização de texto
- [ ] Tamanho máximo (4KB)
- [ ] Rejeição de campos desconhecidos

## Hardening

- [ ] Obfuscation habilitado
- [ ] Minification habilitado
- [ ] R8 habilitado
- [ ] Sem logs em produção
- [ ] Sem debug em produção
- [ ] Sem DevTools em produção

## LGPD

- [ ] Consentimento explícito
- [ ] Política de privacidade
- [ ] Direitos do titular
- [ ] Exportação de dados
- [ ] Exclusão de dados

## Compliance

- [ ] LGPD compliance
- [ ] GDPR compliance (se aplicável)
- [ ] Store policies compliance
- [ ] Privacy labels atualizadas
- [ ] Data safety atualizado

## Monitoramento

- [ ] Sem telemetry
- [ ] Sem crash reporting
- [ ] Sem analytics
- [ ] Apenas suporte ao usuário
- [ ] Canal de feedback

## Verificação

```bash
# Análise de segurança
flutter analyze

# Testes de segurança
flutter test test/security/

# Verificação de dependências
dart pub audit

# Verificação de licenças
dart pub deps --no-dev --style=compact
```
