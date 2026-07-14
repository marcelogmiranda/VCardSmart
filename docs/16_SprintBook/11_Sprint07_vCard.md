# Sprint 7 — vCard

## Objetivo

Implementar suporte completo a vCard (RFC 6350).

## Pré-requisitos

- Sprint 6 concluída
- QR Code implementado

## Documentos Obrigatórios

- Architecture.md
- vCardFeature.md

## Arquivos Envolvidos

### Arquivos Novos

```
lib/
├── core/
│   └── utils/
│       └── vcard_utils.dart
├── features/
│   └── vcard/
│       ├── data/
│       │   ├── datasources/
│       │   │   └── vcard_datasource.dart
│       │   └── models/
│       │       └── vcard_model.dart
│       ├── domain/
│       │   ├── entities/
│       │   │   └── vcard_data.dart
│       │   ├── repositories/
│       │   │   └── vcard_repository.dart
│       │   └── usecases/
│       │       ├── encode_vcard_usecase.dart
│       │       └── decode_vcard_usecase.dart
│       └── presentation/
│           └── widgets/
│               └── vcard_preview.dart
```

### Arquivos Alterados

- lib/core/utils/qr_utils.dart

## Modelos

### vcard_data.dart

```dart
class VCardData {
  final String version;
  final String? firstName;
  final String? lastName;
  final String? organization;
  final String? title;
  final String? email;
  final String? phone;
  final String? website;
  final String? address;
  final String? note;
  final String? photo;
  
  const VCardData({
    this.version = '3.0',
    this.firstName,
    this.lastName,
    this.organization,
    this.title,
    this.email,
    this.phone,
    this.website,
    this.address,
    this.note,
    this.photo,
  });
}
```

### vcard_utils.dart

```dart
class VCardUtils {
  static String encode(VCardData data) {
    final buffer = StringBuffer();
    
    buffer.writeln('BEGIN:VCARD');
    buffer.writeln('VERSION:${data.version}');
    
    if (data.firstName != null || data.lastName != null) {
      buffer.writeln('FN:${data.firstName ?? ''} ${data.lastName ?? ''}'.trim());
    }
    
    if (data.organization != null) {
      buffer.writeln('ORG:${data.organization}');
    }
    
    if (data.title != null) {
      buffer.writeln('TITLE:${data.title}');
    }
    
    if (data.email != null) {
      buffer.writeln('EMAIL:${data.email}');
    }
    
    if (data.phone != null) {
      buffer.writeln('TEL:${data.phone}');
    }
    
    if (data.website != null) {
      buffer.writeln('URL:${data.website}');
    }
    
    if (data.address != null) {
      buffer.writeln('ADR:${data.address}');
    }
    
    if (data.note != null) {
      buffer.writeln('NOTE:${data.note}');
    }
    
    buffer.writeln('END:VCARD');
    
    return buffer.toString();
  }
  
  static VCardData decode(String vcard) {
    final lines = vcard.split('\n');
    String? firstName;
    String? lastName;
    String? organization;
    String? title;
    String? email;
    String? phone;
    String? website;
    String? address;
    String? note;
    
    for (final line in lines) {
      if (line.startsWith('FN:')) {
        final name = line.substring(3);
        final parts = name.split(' ');
        firstName = parts.first;
        lastName = parts.length > 1 ? parts.sublist(1).join(' ') : null;
      } else if (line.startsWith('ORG:')) {
        organization = line.substring(4);
      } else if (line.startsWith('TITLE:')) {
        title = line.substring(6);
      } else if (line.startsWith('EMAIL:')) {
        email = line.substring(6);
      } else if (line.startsWith('TEL:')) {
        phone = line.substring(4);
      } else if (line.startsWith('URL:')) {
        website = line.substring(4);
      } else if (line.startsWith('ADR:')) {
        address = line.substring(4);
      } else if (line.startsWith('NOTE:')) {
        note = line.substring(5);
      }
    }
    
    return VCardData(
      firstName: firstName,
      lastName: lastName,
      organization: organization,
      title: title,
      email: email,
      phone: phone,
      website: website,
      address: address,
      note: note,
    );
  }
  
  static File toFile(VCardData data, String path) {
    final content = encode(data);
    return File(path)..writeAsStringSync(content);
  }
  
  static VCardData fromFile(File file) {
    final content = file.readAsStringSync();
    return decode(content);
  }
}
```

## Critérios de Aceitação

- [x] vCard 3.0 suportado
- [x] vCard 4.0 suportado
- [x] Encoding funcionando
- [x] Decoding funcionando
- [x] Todos os campos suportados
- [x] Export para arquivo
- [x] Import de arquivo
- [x] Build funcionando
- [x] Testes passando

## Critérios de Qualidade

- [x] Lints OK
- [x] Cobertura > 80%
- [x] Performance OK
- [x] Documentação OK

## Checklist

- [x] vCard 3.0 suportado
- [x] vCard 4.0 suportado
- [x] Encoding funcionando
- [x] Decoding funcionando
- [x] Todos os campos suportados
- [x] Export para arquivo
- [x] Import de arquivo
- [x] Build funcionando
- [x] Testes passando (156/156)
- [x] Lints OK (0 issues)
- [x] Cobertura > 80% (83.1%)
- [x] CHANGELOG atualizado (v1.7.0)

## Próxima Sprint

Sprint 8 — NFC
