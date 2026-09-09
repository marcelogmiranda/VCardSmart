# Changelog

Todas as mudanças notáveis do VCardSmart são documentadas neste arquivo.

O formato segue [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/) e o versionamento segue [SemVer](https://semver.org/lang/pt-BR/) com numeração única Play/iOS (`version+built`).

## [1.0.6+14] — 2026-09-09 (em validação)

### Adicionado
- Nova aba **NFC** na barra de navegação (posição 3, antes de Configurações), com detecção automática de disponibilidade:
  - NFC disponível: ações "Gravar Cartão" e "Receber Contato".
  - NFC indisponível: mensagem amigável + botão "Voltar ao Início".

### Melhorado
- **Versão dinâmica** em Configurações via `package_info_plus` (mostra `versão+número` real).
- **Home**: card de perfil agora exibe nome, foto, email e telefone reais quando há perfil; erro de compartilhamento tratado de forma amigável.
- **Auth**: dead-end sem PIN/biometria resolvido com botão "Configurar Segurança".
- **Settings**: desativar PIN/biometria exige confirmação; correção de typos.
- **Migração de dispositivo**: mensagens de erro amigáveis (senha incorreta, arquivo corrompido, caminho inacessível) e toggle mostrar/esconder senha.
- **Contatos**: lista ordenada alfabeticamente, exclusão por swipe com confirmação, empty state com CTA, pull-to-refresh e SnackBar de sucesso ao importar.
- **NFC receive**: botão "Voltar" só em success/error (não interrompe a sessão durante o polling); corpo scrollável.
- **Qualidade visual**: substituição de cores hardcoded por tokens do tema (dark mode), botões full-width, sem espaço reservado quando o banner de anúncio falha.
- **PIN setup**: estado de salvamento com feedback visual.

## [1.0.5+13] — 2026-08-31 (não publicado nas lojas)

### Adicionado
- **Migração de dispositivo**: export/import de backup criptografado `.vcs` (AES + senha) com profiles, contatos, settings e hash do PIN.
- **Cartão NFC externo em vCard 3.0 padrão** (`text/vcard`), legível por qualquer app de Contatos; mantém retrocompatibilidade com o formato legado.

### Melhorado
- **Memória**: avatares decodificados em 224px (`ResizeImage`), inicialização do AdMob única por processo, lookup de foto por prefixo do profile.
- Tela "Gravar em Cartão NFC" acessível a partir do Home.

## [1.0.4+12] — 2026-08-15

### Corrigido
- Suporte a **16 KB page size** (requisito Google Play): atualização de `mlkit barcode-scanning 17.3.0` e CameraX `1.5.3`.
- **Edge-to-edge** (targetSdk 36): `WindowCompat.setDecorFitsSystemWindows(window, false)`.
- Cards de Home unificados ("Meu QR Code" + "Compartilhar" em um único card).

## [1.0.3+11] — 2026-08-12

### Corrigido
- `targetSdk = 36` (exigência Google Play a partir de 31/08/2026) com `versionCode=11`.

## [1.0.2+10] — 2026-08-? 

### Adicionado
- Primeiro IPA enviado ao App Store Connect.

## [1.0.1+9] — 2026-08-? 

### Adicionado
- Build iOS em TestFlight.

## [1.0.0+8] — 2026-08-10

### Adicionado
- Primeira versão publicada na Google Play.
- Fluxo de onboarding com segurança (biometria/PIN), perfil, QR Code, vCard, contatos e NFC.