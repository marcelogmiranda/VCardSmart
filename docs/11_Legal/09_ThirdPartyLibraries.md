# Bibliotecas de Terceiros — VCardSmart

## Dependências

| Biblioteca | Licença | Uso |
|------------|---------|-----|
| Flutter | BSD | Framework |
| Hive | Apache 2.0 | Armazenamento local |
| Riverpod | MIT | Gerenciamento de estado |
| GoRouter | BSD | Navegação |
| Flutter Secure Storage | BSD | Armazenamento seguro |
| Local Auth | BSD | Autenticação biométrica |
| Mobile Scanner | MIT | Leitura de QR Code |
| NFC Manager | MIT | Leitura/escrita NFC |
| Share Plus | BSD | Compartilhamento |
| URL Launcher | BSD | Abrir URLs |
| Google Mobile Ads | Google SDK License | Anúncios |
| UUID | MIT | Geração de IDs |
| JSON Annotation | MIT | Anotações JSON |
| Freezed Annotation | MIT | Modelos imutáveis |

## Dev Dependencies

| Biblioteca | Licença | Uso |
|------------|---------|-----|
| Flutter Test | BSD | Testes |
| Mockito | BSD | Mocking |
| Patrol | MIT | Testes E2E |
| Build Runner | MIT | Geração de código |
| Freezed | MIT | Modelos imutáveis |
| JSON Serializable | MIT | Serialização JSON |
| Flutter Lints | BSD | Regras de lint |

## Detalhes por Biblioteca

### Flutter

- **Licença**: BSD
- **Uso**: Framework principal
- **Link**: https://flutter.dev

### Hive

- **Licença**: Apache 2.0
- **Uso**: Armazenamento local criptografado
- **Link**: https://hive.io

### Riverpod

- **Licença**: MIT
- **Uso**: Gerenciamento de estado
- **Link**: https://riverpod.dev

### GoRouter

- **Licença**: BSD
- **Uso**: Navegação declarativa
- **Link**: https://pub.dev/packages/go_router

### Flutter Secure Storage

- **Licença**: BSD
- **Uso**: Armazenamento seguro (chaves, PIN)
- **Link**: https://pub.dev/packages/flutter_secure_storage

### Local Auth

- **Licença**: BSD
- **Uso**: Autenticação biométrica
- **Link**: https://pub.dev/packages/local_auth

### Mobile Scanner

- **Licença**: MIT
- **Uso**: Leitura de QR Code
- **Link**: https://pub.dev/packages/mobile_scanner

### NFC Manager

- **Licença**: MIT
- **Uso**: Leitura/escrita NFC
- **Link**: https://pub.dev/packages/nfc_manager

### Share Plus

- **Licença**: BSD
- **Uso**: Compartilhamento nativo
- **Link**: https://pub.dev/packages/share_plus

### URL Launcher

- **Licença**: BSD
- **Uso**: Abrir URLs e apps
- **Link**: https://pub.dev/packages/url_launcher

### Google Mobile Ads

- **Licença**: Google SDK License
- **Uso**: Exibição de anúncios
- **Link**: https://pub.dev/packages/google_mobile_ads

## Verificação de Licenças

### Comando

```bash
# Listar dependências e licenças
flutter pub deps --no-dev --style=compact
```

### Script

```dart
// scripts/check_licenses.dart
import 'dart:io';

void main() async {
  final result = await Process.run('flutter', ['pub', 'deps', '--no-dev']);
  
  final output = result.stdout.toString();
  
  // Analisar licenças
  final licenses = parseLicenses(output);
  
  // Verificar compatibilidade
  for (final license in licenses) {
    if (!isCompatible(license)) {
      print('LICENÇA INCOMPATÍVEL: ${license.package}');
    }
  }
}
```

## Processo de Inclusão

### 1. Verificar Licença

```bash
# Verificar licença do pacote
flutter pub deps
```

### 2. Verificar Manutenção

```dart
// Verificar última atualização
final package = await getPackageInfo('nome_do_pacote');
print('Última atualização: ${package.lastUpdated}');
print('Manutenção ativa: ${package.isActive}');
```

### 3. Verificar Segurança

```bash
# Verificar vulnerabilidades
dart pub audit
```

### 4. Documentar

```markdown
## Nova Dependência

**Pacote**: [nome]
**Versão**: [versão]
**Licença**: [licença]
**Uso**: [descrição]
**Manutenção**: [ativa/inativa]
**Vulnerabilidades**: [nenhuma/encontradas]
```

## Checklist de Inclusão

- [ ] Licença verificada
- [ ] Licença compatível
- [ ] Manutenção ativa
- [ ] Sem vulnerabilidades conhecidas
- [ ] Compatível com Flutter Stable
- [ ] Documentada
- [ ] Aprovada por Tech Lead
