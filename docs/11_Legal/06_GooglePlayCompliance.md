# Conformidade Google Play — VCardSmart

## Developer Policy Center

### User Data

**Política**: Dados do usuário devem ser tratados com cuidado.

**Conformidade**:
- ✅ Sem coleta de dados
- ✅ Sem envio de dados
- ✅ Sem compartilhamento com terceiros
- ✅ Dados 100% locais
- ✅ Criptografia obrigatória

### Permissions

**Política**: Permissões devem ser justificadas.

**Conformidade**:
- ✅ Câmera: Leitura de QR Code
- ✅ NFC: Compartilhamento (opcional)
- ✅ Contatos: Salvar na agenda (opcional)
- ✅ Biometria: Proteção (opcional)
- ✅ Internet: Anúncios e atualização

### Data Safety

**Política**: Declaração obrigatória de práticas de dados.

**Conformidade**:
- ✅ Dados coletados: Nenhum
- ✅ Dados compartilhados: Nenhum
- ✅ Dados vendidos: Nenhum
- ✅ Criptografia: AES-256
- ✅ Exclusão: Remoção completa

### Ads Policy

**Política**: Anúncios devem seguir políticas.

**Conformidade**:
- ✅ Google Mobile Ads
- ✅ Sem anúncios personalizados
- ✅ Sem coleta adicional
- ✅ Não interrompe fluxos críticos

### Families Policy

**Não aplicável**: Aplicativo não direcionado para crianças.

## Store Listing

### Ícone

- [x] 512x512 PNG
- [x] Sem transparência
- [x] Sem arredondamento

### Screenshots

- [x] Phone (16:9) — mínimo 2
- [x] Tablet (16:9) — mínimo 2
- [x] Chromebook — mínimo 1 (opcional)

### Feature Graphic

- [x] 1024x500 PNG
- [x] Imagens promocionais

### Descrição

- [x] Título (máx. 30 caracteres)
- [x] Descrição curta (máx. 80 caracteres)
- [x] Descrição completa (máx. 4000 caracteres)

### Classificação Indicativa

- [x] Preenchida corretamente
- [x] Conteúdo programático declarado

### Data Safety

- [x] Tipos de dados coletados
- [x] Finalidade da coleta
- [x] Compartilhamento com terceiros
- [x] Práticas de segurança
- [x] Processo de exclusão

### Permissões

- [x] Permissões justificadas
- [x] Descrição de cada permissão

### Release Notes

- [x] Novidades da versão
- [x] Correções de bugs
- [x] Melhorias de performance

## Target SDK

> Requisito Google Play (31/ago/2026): novas versões e updates devem ter como alvo
> **Android 16 (API level 36)** ou superior. Migrado de 35 → 36 em 1.0.3+11.

```yaml
# android/app/build.gradle.kts
android {
    compileSdk = flutter.compileSdkVersion   # 36 (Flutter 3.44)
    defaultConfig {
        targetSdk = 36
        minSdk = flutter.minSdkVersion       # 24
    }
}
```

## Versionamento

```yaml
# pubspec.yaml — versão única para Android (Play) e iOS (App Store)
version: 1.0.3+11

# iOS: CFBundleShortVersionString=$(FLUTTER_BUILD_NAME) e CFBundleVersion=$(FLUTTER_BUILD_NUMBER)
# Android: versionName/versionCode = flutter.versionName/versionCode
```

## Publishing

### Internal Testing

```yaml
track: internal
status: completed
fraction: 100
```

### Closed Testing

```yaml
track: alpha
status: inProgress
fraction: 10
```

### Open Testing

```yaml
track: beta
status: inProgress
fraction: 100
```

### Production

```yaml
track: production
status: completed
fraction: 100
rollout:
  status: inProgress
  fraction: 10
```

## Compliance Checklist

### Dados

- [x] Sem coleta de dados
- [x] Sem envio de dados
- [x] Sem compartilhamento com terceiros
- [x] Criptografia obrigatória
- [x] Exclusão completa

### Permissões

- [x] Câmera justificada
- [x] NFC justificada
- [x] Contatos justificada
- [x] Biometria justificada
- [x] Internet justificada

### Anúncios

- [x] Google Mobile Ads
- [x] Sem personalização
- [x] Sem coleta adicional
- [x] Não interrompe fluxos

### Store Listing

- [x] Ícone correto
- [x] Screenshots adequadas
- [x] Descrição completa
- [x] Classificação indicativa
- [x] Data Safety preenchido

### Versionamento

- [x] Semantic versioning
- [x] Build number incrementado
- [x] Target SDK atualizado
