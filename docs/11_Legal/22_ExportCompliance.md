# Export Compliance — Criptografia (App Store Connect)

## Contexto

O VCardSmart usa criptografia **padrão** (algoritmos de commodity) em dois pontos:

1. **AES-256** — criptografia do backup local `.vcs` (migração de dispositivo), dados em repouso, processados 100% no aparelho.
2. **TLS/HTTPS (TLS 1.2/1.3)** — comunicação segura padrão usada pelos SDKs de anúncio (Google AdMob) para tráfego de rede.

Não há algoritmo proprietário, não há crypto customizada, não há geração/importação de chaves pelo usuário além do próprio mecanismo do app. Isso se enquadra na categoria **"mass-market / standard encryption"** do EAR (15 CFR § 740.17(b)(2)) — **isenta** de relatório individual.

## Como responder no App Store Connect (recomendado — sem upload de arquivo)

Em **App Store Connect → seu App → Versão → Export Compliance**:

1. **"Does your app use encryption?"** → **Yes**
2. **"Does your app qualify for any of the exemptions provided by the Export Compliance regulations?"** → **Yes**
3. Selecionar a opção: **"The app uses only standard encryption and qualifies under an exemption"** (opção de *mass-market / ENC exemption*).

Com isso o App Store Connect **não exige documento anexo** — a versão segue sem a pendência de upload.

> ⚠️ Se a versão já foi submetida/está com "documentation required", volte à tela de Export Compliance, mude a resposta para a opção acima e **submeta novamente** (a versão anterior pode continuar com a pendência se não reenviar).

## Caso a Apple ainda peça o documento (upload do .pdf)

Se a revisão insistir em um anexo, suba uma carta de **Self-Classification / Export Compliance Documentation** (template abaixo). Salve como PDF com o app e versão no nome (ex.: `VCardSmart-1.0.6-14_ExportCompliance.pdf`).

## Template da carta (PDF)

```text
ENCRYPTION COMPLIANCE DOCUMENTATION

Application: VCardSmart
App Store Connect version: 1.0.6 (Build 14)
Bundle Identifier: com.vcardsmart.app
Developer: [Nome Legal / Empresa]
Date: [dd/mm/yyyy]

1. Use of Encryption
VCardSmart uses cryptography solely for:
  a) Data protection at rest: local device backup files (.vcs) are
     encrypted on-device using AES-256 (256-bit key, standard
     implementation). No encrypted data leaves the device except
     user-initiated backup sharing.
  b) Secure network communication: the application and its third-party
     advertising SDK (Google AdMob) communicate over standard TLS/HTTPS.

2. Algorithms and Implementation
  - AES-256 (encryption for data at rest) — standard/commodity algorithm.
  - TLS 1.2/1.3 for transport security — standard cryptography provided
    by the operating system.
  - No proprietary, non-standard or custom cryptographic algorithms are
    implemented.

3. Classification / Basis for Exemption
  The cryptographic functionality is considered "mass-market" software
  under U.S. Export Administration Regulations, EAR Category 5 Part 2
  (ECCN 5D992 / 5A992.c), and qualifies for the exemption provided in
  15 CFR § 740.17(b)(2). The Encrypted Data "ENC" classification applies:
  the product is exempt from the reporting requirements applicable to
  non-standard encryption. Additionally, distribution through the App
  Store qualifies for the Apple App Store exception for products using
  standard encryption.

4. Conclusion
  No additional export compliance documentation or authorization is
  required for this release under applicable U.S. regulations.

Signature/Approval:
Name: ______________________
Role: ______________________
Email: _____________________
```

## Links úteis

- Apple: https://developer.apple.com/help/app-store-connect/reference/export-compliance-information/
- Apple: https://developer.apple.com/documentation/security/strong-encryption
- EAR 740.17: https://www.ecfr.gov/current/title-15/subtitle-B/chapter-VII/subchapter-C/part-740/subpart-D/section-740.17