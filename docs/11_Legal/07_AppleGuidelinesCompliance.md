# Conformidade Apple Guidelines — VCardSmart

## App Store Review Guidelines

### Privacy (Section 5)

**Política**: Apps devem seguir práticas de privacidade.

**Conformidade**:
- ✅ Sem coleta de dados
- ✅ Sem envio de dados
- ✅ Sem compartilhamento com terceiros
- ✅ Dados 100% locais
- ✅ Criptografia obrigatória

### Permissions (Section 5.1.1)

**Política**: Permissões devem ser justificadas.

**Conformidade**:
- ✅ Câmera: Leitura de QR Code
- ✅ NFC: Compartilhamento (opcional)
- ✅ Contatos: Salvar na agenda (opcional)
- ✅ Face ID: Proteção (opcional)
- ✅ Internet: Anúncios e atualização

### Security (Section 2.3.1)

**Política**: Apps devem ser seguros.

**Conformidade**:
- ✅ Criptografia AES-256
- ✅ Secure Storage
- ✅ Autenticação opcional
- ✅ Sem logs em produção
- ✅ Hardening habilitado

### Human Interface Guidelines

**Política**: Apps devem seguir HIG.

**Conformidade**:
- ✅ Design consistente
- ✅ Acessibilidade
- ✅ Feedback visual
- ✅ Navegação intuitiva

## Privacy Nutrition Labels

### Dados Coletados

| Dado | Vinculado ao Usuário | Usado para Rastreamento |
|------|---------------------|------------------------|
| Nome | ❌ | ❌ |
| Email | ❌ | ❌ |
| Telefone | ❌ | ❌ |
| Empresa | ❌ | ❌ |
| Configurações | ❌ | ❌ |

### Declaração

- ❌ Nenhum dado vinculado ao usuário
- ❌ Nenhum dado usado para rastreamento
- ❌ Nenhum analytics
- ✅ Somente Google Mobile Ads não personalizado

## App Privacy Details

### Dados Coletados

| Categoria | Dados | Uso |
|-----------|-------|-----|
| Identificação | Nome | Perfil |
| Contato | Email, Telefone | Perfil |
| Profissional | Empresa | Perfil |

### Dados Compartilhados

| Categoria | Dados | Finalidade |
|-----------|-------|------------|
| Nenhum | - | - |

### Dados Vendidos

| Categoria | Dados | Finalidade |
|-----------|-------|------------|
| Nenhum | - | - |

## Local Authentication

### Face ID / Touch ID

```xml
<!-- ios/Runner/Info.plist -->
<key>NSFaceIDUsageDescription</key>
<string>Use Face ID para acessar o aplicativo</string>
```

### Biometrics

```dart
// Configuração
final authenticated = await LocalAuth.authenticate(
  localizedReason: 'Autentique-se para acessar',
  options: const AuthenticationOptions(
    stickyAuth: true,
    biometricOnly: false,
  ),
);
```

## NFC

### Configuração

```xml
<!-- ios/Runner/Info.plist -->
<key>NFCReaderUsageDescription</key>
<string>Use NFC para compartilhar cartões de visita</string>
```

### Uso

```dart
// Leitura
await NfcManager.instance.startSession(
  onDiscovered: (NfcTag tag) async {
    // Processar tag
  },
);
```

## Camera

### Configuração

```xml
<!-- ios/Runner/Info.plist -->
<key>NSCameraUsageDescription</key>
<string>Para escanear QR Codes</string>
```

### Uso

```dart
// Verificar permissão
final status = await Permission.camera.request();
if (status.isGranted) {
  // Usar câmera
}
```

## Contacts

### Configuração

```xml
<!-- ios/Runner/Info.plist -->
<key>NSContactsUsageDescription</key>
<string>Para salvar contatos na agenda</string>
```

### Uso

```dart
// Verificar permissão
final status = await Permission.contacts.request();
if (status.isGranted) {
  // Acessar contatos
}
```

## Store Listing

### App Icon

- [x] 1024x1024 PNG
- [x] Sem transparência
- [x] Sem arredondamento

### Screenshots

- [x] iPhone 6.7" (iPhone 15 Pro Max)
- [x] iPhone 6.5" (iPhone 14 Plus)
- [x] iPhone 5.5" (iPhone 8 Plus)
- [x] iPad Pro 12.9" (6th gen)
- [x] iPad Pro 12.9" (2nd gen)

### Descrição

- [x] Nome (máx. 30 caracteres)
- [x] Subtítulo (máx. 30 caracteres)
- [x] Descrição (máx. 4000 caracteres)
- [x] Keywords (máx. 100 caracteres)

### App Review Information

- [x] Notas de revisão
- [x] Informações de contato
- [x] Demonstração (se necessário)

### Release Notes

- [x] Novidades da versão
- [x] Correções de bugs
- [x] Melhorias de performance

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
- [x] Face ID justificada
- [x] Internet justificada

### Privacidade

- [x] Privacy Labels preenchidas
- [x] App Privacy preenchido
- [x] Política de privacidade publicada

### Store Listing

- [x] Ícone correto
- [x] Screenshots adequadas
- [x] Descrição completa
- [x] Keywords definidos

### Revisão

- [x] Sem violações de guidelines
- [x] Funcionalidades funcionando
- [x] Links funcionais
