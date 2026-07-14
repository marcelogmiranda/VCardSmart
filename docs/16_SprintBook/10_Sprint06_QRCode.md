# Sprint 6 — QR Code

## Objetivo

Implementar geração e leitura de QR Code.

## Pré-requisitos

- Sprint 5 concluída
- Photo Module implementado

## Documentos Obrigatórios

- Architecture.md
- QRCodeFeature.md

## Arquivos Envolvidos

### Arquivos Novos

```
lib/
├── core/
│   └── utils/
│       └── qr_utils.dart
├── features/
│   └── qr_code/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── qr_datasource.dart
│       │   └── models/
│       │       └── qr_payload.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── qr_data.dart
│       │   ├── repositories/
│       │   │   └── qr_repository.dart
│       │   └── usecases/
│       │       ├── generate_qr_usecase.dart
│       │       └── scan_qr_usecase.dart
│       └── presentation/
│           ├── pages/
│           │   ├── qr_share_page.dart
│           │   └── qr_scan_page.dart
│           ├── widgets/
│           │   ├── qr_code_widget.dart
│           │   └── qr_scanner_widget.dart
│           └── providers/
│               └── qr_provider.dart
```

### Arquivos Alterados

- lib/core/router/app_router.dart
- pubspec.yaml

## Modelos

### qr_data.dart

```dart
class QRData {
  final String type;
  final String payload;
  final DateTime timestamp;
  
  const QRData({
    required this.type,
    required this.payload,
    required this.timestamp,
  });
}
```

### qr_payload.dart

```dart
class QRPayload {
  static String encodeVCard(Profile profile) {
    return 'BEGIN:VCARD\n'
        'VERSION:3.0\n'
        'FN:${profile.name}\n'
        'EMAIL:${profile.email ?? ''}\n'
        'TEL:${profile.phone ?? ''}\n'
        'URL:${profile.website ?? ''}\n'
        'END:VCARD';
  }
  
  static Profile decodeVCard(String payload) {
    // Decodificar vCard
  }
}
```

### qr_repository.dart

```dart
abstract class QRRepository {
  Future<String> generateQR(Profile profile);
  Future<Profile> scanQR();
  Future<Profile> decodeQR(String data);
}
```

### generate_qr_usecase.dart

```dart
class GenerateQRUseCase {
  final QRRepository repository;
  
  GenerateQRUseCase(this.repository);
  
  Future<String> call(Profile profile) {
    return repository.generateQR(profile);
  }
}
```

### scan_qr_usecase.dart

```dart
class ScanQRUseCase {
  final QRRepository repository;
  
  ScanQRUseCase(this.repository);
  
  Future<Profile> call() {
    return repository.scanQR();
  }
}
```

### qr_code_widget.dart

```dart
class QRCodeWidget extends StatelessWidget {
  final String data;
  final double size;
  
  const QRCodeWidget({
    super.key,
    required this.data,
    this.size = 200,
  });
  
  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: data,
      size: size,
      backgroundColor: Colors.white,
    );
  }
}
```

### qr_scanner_widget.dart

```dart
class QRScannerWidget extends StatelessWidget {
  final Function(String) onScanned;
  
  const QRScannerWidget({
    super.key,
    required this.onScanned,
  });
  
  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      onDetect: (capture) {
        final barcode = capture.barcodes.first;
        if (barcode.rawValue != null) {
          onScanned(barcode.rawValue!);
        }
      },
    );
  }
}
```

## Critérios de Aceitação

- [x] Geração de QR Code funcionando
- [x] Leitura de QR Code funcionando
- [x] vCard encoding funcionando
- [x] vCard decoding funcionando
- [x] Tamanho configurável
- [x] Personalização de cores
- [x] Build funcionando
- [x] Testes passando

## Critérios de Qualidade

- [x] Lints OK
- [x] Cobertura > 80%
- [x] Performance OK
- [x] Documentação OK

## Checklist

- [x] Geração de QR Code funcionando
- [x] Leitura de QR Code funcionando
- [x] vCard encoding funcionando
- [x] vCard decoding funcionando
- [x] Tamanho configurável
- [x] Personalização de cores
- [x] Build funcionando
- [x] Testes passando (127/127)
- [x] Lints OK (0 issues)
- [x] Cobertura > 80% (82.0%)
- [x] CHANGELOG atualizado (v1.6.0)

## Próxima Sprint

Sprint 7 — vCard
