# Code Signing — VCardSmart

## Android

### Keystore

```bash
# Criar keystore
keytool -genkey -v \
  -keystore vcardsmart-release.keystore \
  -alias vcardsmart \
  -keyalg RSA \
  -keysize 2048 \
  -validity 10000

# Informações:
# - Nome: VCardSmart
# - Organização: VCardSmart
# - Cidade: São Paulo
# - Estado: SP
# - País: BR
```

### Configuração

```groovy
// android/app/build.gradle
android {
    signingConfigs {
        release {
            keyAlias 'vcardsmart'
            keyPassword System.getenv('KEY_PASSWORD') ?: ''
            storeFile file('vcardsmart-release.keystore')
            storePassword System.getenv('STORE_PASSWORD') ?: ''
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

### GitHub Secrets

| Secret | Descrição |
|--------|-----------|
| `KEY_PASSWORD` | Senha da chave |
| `STORE_PASSWORD` | Senha do keystore |
| `KEYSTORE_BASE64` | Keystore em base64 |

## iOS

### Certificados

```bash
# Listar certificados
security find-identity -v -p codesigning

# Exportar certificado
openssl pkcs12 -export -out certificate.p12 -inkey privateKey.pem -in certificate.pem
```

### Provisioning Profile

```bash
# Listar provisioning profiles
ls ~/Library/MobileDevice/Provisioning\ Profiles/

# Verificar provisioning profile
security cms -D -i profile.mobileprovision
```

### Configuração no Xcode

1. Abrir `ios/Runner.xcworkspace`
2. Selecionar target Runner
3. Configurar Signing & Capabilities:
   - Team: Seu time
   - Bundle Identifier: com.vcardsmart
   - Signing Certificate: Apple Distribution
   - Provisioning Profile: VCardSmart Distribution

### GitHub Secrets

| Secret | Descrição |
|--------|-----------|
| `APPLE_TEAM_ID` | Team ID Apple |
| `APPLE_CERTIFICATE_BASE64` | Certificado em base64 |
| `APPLE_CERTIFICATE_PASSWORD` | Senha do certificado |
| `APPLE_PROVISION_PROFILE_BASE64` | Provisioning profile em base64 |

## Boas Práticas

1. **Nunca versionar certificados** no repositório
2. **Usar variáveis de ambiente** para senhas
3. **Rotacionar certificados** periodicamente
4. **Usar Fastlane Match** para equipes
5. **Manter backups seguros** dos certificados

## Segurança

```bash
# Adicionar ao .gitignore
*.keystore
*.jks
*.p12
*.mobileprovision
*.cer
```

## Troubleshooting

| Problema | Solução |
|----------|---------|
| Keystore não encontrado | Verificar caminho no build.gradle |
| Certificado expirado | Renovar no Apple Developer |
| Provisioning inválido | Regenerar no Apple Developer |
| Signing failed | Verificar secrets do GitHub |
