# Checklist de Release — VCardSmart

Situação atual: **ronda v1.0.6+14 (09/09)** — artifacts finais em `~/Downloads/VCardSmart-1.0.6-14.{aab,ipa}` (AAB SHA-256 `c8a65775…813dd`, IPA SHA-256 `0f358883…93052`). **Android na Play — testes aberto/fechado**; **iOS no ASC, Export Compliance resolvido como exempt** (sem upload de doc), aguardando submissão do IPA. Itens verificados marcados; demais pendentes de validação em device / formulários das lojas.

## Pré-Release

### 1. Código

- [x] `flutter analyze` — Sem erros ou warnings (No issues found, 09/09)
- [x] `dart format` — Código formatado (54 arquivos; `dart format` como canônico; removido lint `require_trailing_commas` que conflitava)
- [x] `flutter test` — Todos os testes passando (472 determinísticos; goldens NÃO rodam na CI)
- [ ] Cobertura de código ≥ 90% (não mensurada — sem tooling configurado)
- [ ] Sem dependências vulneráveis (sem scanner configurado — checar `flutter pub outdated`/Dependabot)
- [x] Sem TODOs pendentes (grep TODO/FIXME/HACK: nenhum)
- [ ] Sem código morto (não auditado)
- [x] Sem imports não utilizados (coberto pelo analyzer)

### 2. Build Android

- [x] `flutter build appbundle --release` — AAB gerado (`app-release.aab`, 65MB)
- [ ] APK gerado e testado (APK debug compilado; teste em device pendente)
- [x] AAB gerado e testado (manifesto: versionCode=14, versionName=1.0.6, targetSdk=36; libs 64-bit p_align ≥ 16384)
- [x] Assinatura válida (release-keystore.jks, key.properties)
- [x] ProGuard configurado (R8 ativo)
- [x] Min SDK correto — **24** (valor atualizado no checklist; antes constava 21)
- [x] Target SDK correto — **36** (exigência Google Play 31/08/2026; antes constava 34)
- [ ] Ícones atualizados (não verificado visualmente)
- [ ] Splash screen atualizado (Flutter default; não verificado)
- [ ] Permissões revisadas (Android: permissões runtime declaradas; validação funcional em device pendente)

### 3. Build iOS

- [x] `flutter build ipa --release` — IPA gerado (`VCardSmart.ipa`, 34MB)
- [x] IPA gerado e validado (CFBundleShortVersionString=1.0.6, CFBundleVersion=14; sem entitlement NFC)
- [x] Provisioning profile válido (App Store: `VCardSmart_App_Store.mobileprovision`)
- [x] Certificado válido (`Apple Distribution: Marcelo Miranda (7775YGF9CJ)`)
- [x] Bundle ID correto (`com.vcardsmart.app`)
- [x] Versão do iOS mínima — **15.0** (deployment target atualizado; antes constava 12.0)
- [ ] Ícones atualizados (não verificado visualmente)
- [ ] Launch screen atualizado (build avisa "Launch image is set to the default placeholder icon")
- [x] Permissões revisadas (iOS: 6 purpose strings no Info.plist — NFC, Camera, Contacts, FaceID, Microphone, PhotoLibrary — pois image_picker/nfc_manager/mobile_scanner referenciam APIs protegidas)

### 4. Testes

- [x] Unit tests passando (472 determinísticos)
- [x] Widget tests passando (472 determinísticos incluem widget tests)
- [~] Integration tests passando (parcial: suíte determinística inclui integration de security; **goldens têm ~29 falhas pré-existentes** e NÃO rodam na CI)
- [ ] Golden tests atualizados (falhas pré-existentes, flaky macOS/Linux; uso local apenas)
- [ ] E2E tests passando (não configurado)
- [ ] Performance tests passando (não configurado)
- [ ] Security tests passando (não configurado)
- [ ] Regression tests passando (não configurado)
- [ ] Compatibility tests passando (validação em device pendente)
- [ ] Accessibility tests passando (não configurado)

### 5. Funcionalidades (validação manual em device — pendente)

- [ ] Perfil — Criar, Editar, Visualizar
- [ ] QR Code — Gerar, Escanear, Compartilhar
- [ ] NFC — Ler, Escrever, Compartilhar
- [ ] vCard — Gerar, Importar, Exportar
- [ ] Agenda — Importar, Exportar (excluir por swipe + pull-to-refresh novos)
- [ ] Configurações — Tema, Idioma, Biometria, PIN (versão dinâmica nova)
- [ ] Modo Offline — Funcionamento completo
- [ ] Anúncios — Exibição correta (banner com shrink em falha)

### 6. Documentação

- [x] README atualizado (versão 1.0.6+14 + migração)
- [x] CHANGELOG atualizado (criado em `CHANGELOG.md`)
- [ ] API docs atualizados (não aplicável — sem API pública)
- [ ] Screenshots atualizados (nova aba NFC; gerar a partir do device)
- [ ] Store listing atualizado (docs de listing em `docs/12_Marketing`; formulários das lojas são manuais)
- [x] Política de privacidade atualizada (docs/PrivacyPolicy.md cobre AdMob/permissoes; **publicar URL** é ação manual) 
- [x] Termos de uso atualizados (docs/11_Legal/03_TermsOfUse.md existe)
- [x] Export Compliance documentação (docs/11_Legal/22_ExportCompliance.md — template carta criptografia; usar apenas se Apple exigir PDF)

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

- [ ] Biometria testada (em device)
- [ ] PIN testado (em device)
- [x] Criptografia verificada (backup .vcs AES + senha; hash PIN SHA-256 device-independent)
- [x] Secure Storage verificado (PIN no flutter_secure_storage, não no Hive)
- [ ] Permissões mínimas (revisão manual pendente)
- [ ] Sem dados sensíveis em logs (não auditado)
- [ ] SSL pinning (se aplicável — sem chamadas de rede próprias, não aplicável)
- [ ] Root/jailbreak detection (se aplicável — não aplicável por ora)

### 9. Performance

- [ ] Inicialização < 2s (não mensurado)
- [ ] Memória < 100MB (otimizações 0.1.5 aplicadas: ResizeImage 224, ads init 1x; não mensurado)
- [ ] CPU < 30% (não mensurado)
- [ ] FPS > 55 (não mensurado)
- [ ] Tamanho do app < 20MB (NÃO alcançável: AAB 65MB / IPA 34MB — Flutter + mobile_scanner + ads)
- [ ] Sem memory leaks (não auditado)
- [ ] Sem ANR/Crash (validação em device pendente)

### 10. Compliance

- [ ] LGPD compliance (decisão de produto)
- [ ] Privacy policy (não há URL/arquivo no projeto — decisão de produto)
- [ ] Terms of service (decisão de produto)
- [x] Data encryption (backup criptografado; Hive local)
- [x] Export Compliance iOS (09/09 RESOLVIDO): marcado no ASC **"standard encryption and qualifies under an exemption"** (mass-market, 15 CFR §740.17(b)(2)) → **sem upload de documento**; template guardado em `docs/11_Legal/22_ExportCompliance.md` p/ eventual necessidade. NÃO marcar "no encryption".
- [ ] User consent (não configurado)
- [ ] Right to deletion (exclusão de contatos por swipe; sem conta servidor)
- [ ] Data portability (migração .vcs export/import — validar em device)

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