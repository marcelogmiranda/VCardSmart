# Checklist de Release — VCardSmart

## Pré-Release

### 1. Código

- [ ] `flutter analyze` — Sem erros ou warnings
- [ ] `dart format` — Código formatado
- [ ] `flutter test` — Todos os testes passando
- [ ] Cobertura de código ≥ 90%
- [ ] Sem dependências vulneráveis
- [ ] Sem TODOs pendentes
- [ ] Sem código morto
- [ ] Sem imports não utilizados

### 2. Build Android

- [ ] `flutter build apprelease` — Build gerado
- [ ] APK gerado e testado
- [ ] AAB gerado e testado
- [ ] Assinatura válida
- [ ] ProGuard configurado
- [ ] Min SDK correto (21)
- [ ] Target SDK correto (34)
- [ ] Ícones atualizados
- [ ] Splash screen atualizado
- [ ] Permissões revisadas

### 3. Build iOS

- [ ] `flutter build ios` — Build gerado
- [ ] IPA gerado e testado
- [ ] Provisioning profile válido
- [ ] Certificado válido
- [ ] Bundle ID correto
- [ ] Versão do iOS mínima (12.0)
- [ ] Ícones atualizados
- [ ] Launch screen atualizado
- [ ] Permissões revisadas

### 4. Testes

- [ ] Unit tests passando
- [ ] Widget tests passando
- [ ] Integration tests passando
- [ ] Golden tests atualizados
- [ ] E2E tests passando
- [ ] Performance tests passando
- [ ] Security tests passando
- [ ] Regression tests passando
- [ ] Compatibility tests passando
- [ ] Accessibility tests passando

### 5. Funcionalidades

- [ ] Perfil — Criar, Editar, Visualizar
- [ ] QR Code — Gerar, Escanear, Compartilhar
- [ ] NFC — Ler, Escrever, Compartilhar
- [ ] vCard — Gerar, Importar, Exportar
- [ ] Agenda — Importar, Exportar
- [ ] Configurações — Tema, Idioma, Biometria, PIN
- [ ] Modo Offline — Funcionamento completo
- [ ] Anúncios — Exibição correta

### 6. Documentação

- [ ] README atualizado
- [ ] CHANGELOG atualizado
- [ ] API docs atualizados
- [ ] Screenshots atualizados
- [ ] Store listing atualizado
- [ ] Política de privacidade atualizada
- [ ] Termos de uso atualizados

### 7. Store

- [ ] Google Play — Listing completo
- [ ] App Store — Listing completo
- [ ] Screenshots — Todas as resoluções
- [ ] Vídeo preview (opcional)
- [ ] Categoria correta
- [ ] Palavras-chave definidas
- [ ] Classificação indicativa
- [ ] Conteúdo programático

### 8. Segurança

- [ ] Biometria testada
- [ ] PIN testado
- [ ] Criptografia verificada
- [ ] Secure Storage verificado
- [ ] Permissões mínimas
- [ ] Sem dados sensíveis em logs
- [ ] SSL pinning (se aplicável)
- [ ] Root/jailbreak detection (se aplicável)

### 9. Performance

- [ ] Inicialização < 2s
- [ ] Memória < 100MB
- [ ] CPU < 30%
- [ ] FPS > 55
- [ ] Tamanho do app < 20MB
- [ ] Sem memory leaks
- [ ] Sem ANR/Crash

### 10. Compliance

- [ ] LGPD compliance
- [ ] Privacy policy
- [ ] Terms of service
- [ ] Data encryption
- [ ] User consent
- [ ] Right to deletion
- [ ] Data portability

## Pós-Release

### 1. Monitoramento

- [ ] Crash reports monitorados
- [ ] Analytics configurados
- [ ] Performance monitoring
- [ ] User feedback monitorado
- [ ] Store reviews monitoradas

### 2. Comunicação

- [ ] Release notes publicadas
- [ ] Equipe notificada
- [ ] Stakeholders informados
- [ ] Blog post (se aplicável)
- [ ] Social media (se aplicável)

### 3. Rollback

- [ ] Plano de rollback definido
- [ ] Versão anterior arquivada
- [ ] Processo de rollback testado
- [ ] Comunicação de rollback pronta

## Assinatura

| Responsável | Data | Status |
|-------------|------|--------|
| Dev Lead | | ☐ Aprovado |
| QA Lead | | ☐ Aprovado |
| Product Owner | | ☐ Aprovado |
| Tech Lead | | ☐ Aprovado |
