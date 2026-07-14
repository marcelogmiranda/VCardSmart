# Sprint 8 — NFC

## Objetivo

Implementar compartilhamento via NFC.

## Pré-requisitos

- Sprint 7 concluída
- vCard implementado

## Documentos Obrigatórios

- Architecture.md
- NFCFeature.md

## Arquivos Envolvidos

### Arquivos Novos

```
lib/
├── core/
│   └── utils/
│       └── nfc_utils.dart
├── features/
│   └── nfc/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── nfc_datasource.dart
│       │   └── models/
│       │       └── nfc_payload.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── nfc_data.dart
│       │   ├── repositories/
│       │   │   └── nfc_repository.dart
│       │   └── usecases/
│       │       ├── send_nfc_usecase.dart
│       │       └── receive_nfc_usecase.dart
│       └── presentation/
│           ├── pages/
│           │   ├── nfc_share_page.dart
│           │   └── nfc_receive_page.dart
│           ├── widgets/
│           │   ├── nfc_status_widget.dart
│           │   └── nfc_instruction_widget.dart
│           └── providers/
│               └── nfc_provider.dart
```

### Arquivos Alterados

- lib/core/router/app_router.dart
- pubspec.yaml

## Modelos

### nfc_data.dart

```dart
class NFCData {
  final String type;
  final String payload;
  final DateTime timestamp;
  
  const NFCData({
    required this.type,
    required this.payload,
    required this.timestamp,
  });
}
```

### nfc_repository.dart

```dart
abstract class NFCRepository {
  Future<bool> isAvailable();
  Future<void> send(Profile profile);
  Future<Profile> receive();
  Future<void> cancel();
}
```

### send_nfc_usecase.dart

```dart
class SendNFCUseCase {
  final NFCRepository repository;
  
  SendNFCUseCase(this.repository);
  
  Future<void> call(Profile profile) {
    return repository.send(profile);
  }
}
```

### receive_nfc_usecase.dart

```dart
class ReceiveNFCUseCase {
  final NFCRepository repository;
  
  ReceiveNFCUseCase(this.repository);
  
  Future<Profile> call() {
    return repository.receive();
  }
}
```

### nfc_status_widget.dart

```dart
class NFCStatusWidget extends StatelessWidget {
  final bool isAvailable;
  
  const NFCStatusWidget({
    super.key,
    required this.isAvailable,
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isAvailable ? Icons.nfc : Icons.nfc_outlined,
          color: isAvailable ? Colors.green : Colors.red,
        ),
        const SizedBox(width: 8),
        Text(isAvailable ? 'NFC disponível' : 'NFC indisponível'),
      ],
    );
  }
}
```

### nfc_instruction_widget.dart

```dart
class NFCInstructionWidget extends StatelessWidget {
  final NFCState state;
  
  const NFCInstructionWidget({
    super.key,
    required this.state,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          _getIcon(state),
          size: 100,
        ),
        const SizedBox(height: 16),
        Text(
          _getText(state),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
  
  IconData _getIcon(NFCState state) {
    switch (state) {
      case NFCState.ready:
        return Icons.nfc;
      case NFCState.sending:
        return Icons.sync;
      case NFCState.receiving:
        return Icons.sync;
      case NFCState.success:
        return Icons.check_circle;
      case NFCState.error:
        return Icons.error;
    }
  }
  
  String _getText(NFCState state) {
    switch (state) {
      case NFCState.ready:
        return 'Aproxime os dispositivos';
      case NFCState.sending:
        return 'Enviando...';
      case NFCState.receiving:
        return 'Recebendo...';
      case NFCState.success:
        return 'Sucesso!';
      case NFCState.error:
        return 'Erro ao comunicar';
    }
  }
}
```

## Critérios de Aceitação

- [x] Verificação de disponibilidade
- [x] Envio de perfil
- [x] Recebimento de perfil
- [x] Validação de dados
- [x] Cancelamento
- [x] Confirmação
- [x] Tratamento de erros
- [x] Build funcionando
- [x] Testes passando

## Critérios de Qualidade

- [x] Lints OK
- [x] Cobertura > 80%
- [x] Performance OK
- [x] Documentação OK

## Checklist

- [x] Verificação de disponibilidade
- [x] Envio de perfil
- [x] Recebimento de perfil
- [x] Validação de dados
- [x] Cancelamento
- [x] Confirmação
- [x] Tratamento de erros
- [x] Build funcionando
- [x] Testes passando (209/209)
- [x] Lints OK (0 issues)
- [x] Cobertura > 80% (82.8%)
- [x] CHANGELOG atualizado (v1.7.0)

## Próxima Sprint

Sprint 9 — Contacts
