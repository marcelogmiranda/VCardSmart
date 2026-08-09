# VCardSmart — Contexto do Projeto

App Flutter de cartões de visita digitais (vCard/QR/NFC). Fluxo atual: submissão à App Store.

## Build / Device
- Sempre prefixar comandos flutter com: `export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"`
- iPhone físico: "iPhone de Marcelo" (iPhone 14, iOS 26.5.2). Identificadores devicectl:
  - UUID legado: `00008110-001468600241401E`
  - CoreDevice atual: `D9CA6E3D-7783-5BC7-B545-498B0D98BC68`
- Install (overwrite) preserva dados Hive. `uninstall` apaga tudo (foi causa da "perda" de perfil anterior).
- Launch: `xcrun devicectl device process launch --device <id> com.vcardsmart.app`
  - Erro `FBSOpenApplicationServiceErrorDomain RequestDenied/Locked`: aparelho bloqueado; tocar no ícone.
- Assinatura App Store: cert `Apple Distribution: Marcelo Miranda (7775YGF9CJ)` já presente.
- Release build device: `flutter build ios --release`
- IPA App Store: `flutter build ipa --release` → `app/build/ios/ipa/VCardSmart.ipa` (subir via Transporter)

## Testes
- Suíte não-golden: `flutter test test/core test/features` → verde (411 testes).
- `test/golden/` tem ~27 falhas pré-existentes (AppAvatar etc.), não relacionadas a mudanças atuais.
- `flutter analyze` → No issues found.

## Pendências (próxima interação)
1. **Testar no Android** com aparelho Android plugado (primeira vez; verificar build/assinação Android).
2. Validar fluxo App Store completo: upload Transporter (em andamento pelo usuário), build no App Store Connect, TestFlight.
3. Contatos ("Preencher do dispositivo"): melhorado (permissão no foco + listar contatos), aguarda revalidação no aparelho.
4. Splash custom incorporado; confirmado OK no device iOS; aguarda confirmação visual no fluxo App Store/TestFlight.

## Histórico de Commits (recente)
- `76cbfd9` feat: add facebook, x and generic social link fields to profile
- `578d4a7` fix: route security setup flow correctly and add integration tests
- `9f77f91` feat: redesigned security onboarding and configurable lock (v1.0.0+8)
- `3ffc72b` fix: upgrade flutter_contacts to 2.3.1 (v1.0.0+7)
- `5ff8fd1` fix: raise iOS deployment target to 15.0 (v1.0.0+6)
