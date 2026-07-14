# Security Architecture

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Pilares de Segurança

| Pilar | Descrição |
|-------|-----------|
| **Hive Encryption** | Criptografia AES para dados sensíveis |
| **Secure Storage** | Armazenamento seguro nativo |
| **Biometria** | Face ID / Impressão digital |
| **PIN** | Fallback quando biometria indisponível |
| **Auto Lock** | Bloqueio automático após timeout |
| **Zero Analytics** | Sem coleta de dados |
| **Zero Cloud** | Sem armazenamento externo |
| **Zero Tracking** | Sem rastreamento |

---

## Camadas de Segurança

### Camada 1: Acesso ao App
| Mecanismo | Descrição |
|-----------|-----------|
| Biometria | Face ID (iOS) / Impressão digital (Android) |
| PIN | Fallback 4-6 dígitos |
| Auto Lock | Timeout configurável |

### Camada 2: Armazenamento
| Mecanismo | Descrição |
|-----------|-----------|
| Hive AES | Criptografia de dados sensíveis |
| Secure Storage | PIN e dados críticos |
| Sem Cloud | Nenhum dado sai do dispositivo |

### Camada 3: Compartilhamento
| Mecanismo | Descrição |
|-----------|-----------|
| Confirmação | Sempre solicitar antes de enviar |
| Seleção | Usuário escolhe o que compartilhar |
| Validação | Validar dados antes de transmitir |

---

## Biometria

### Detecção
```dart
class BiometricService {
  Future<bool> isAvailable() async {
    return await LocalAuthentication().canCheckBiometrics;
  }

  Future<BiometricType> getAvailableBiometrics() async {
    return await LocalAuthentication().getAvailableBiometrics();
  }
}
```

### Autenticação
```dart
Future<bool> authenticate() async {
  return await LocalAuthentication().authenticate(
    localizedReason: 'Autentique-se para acessar o app',
    options: const AuthenticationOptions(
      stickyAuth: true,
      biometricOnly: false, // Permite PIN como fallback
    ),
  );
}
```

---

## PIN

### Armazenamento
```dart
// PIN é armazenado com hash
final hashedPin = hashPin(pin);
await secureStorage.write(key: 'pin', value: hashedPin);
```

### Validação
```dart
Future<bool> validatePin(String inputPin) async {
  final storedPin = await secureStorage.read(key: 'pin');
  return hashPin(inputPin) == storedPin;
}
```

---

## Auto Lock

| Configuração | Valor Padrão |
|-------------|--------------|
| Timeout | 5 minutos |
| Bloqueio ao minimizar | Sim |
| Bloqueio ao trocar app | Sim |

---

## Dados Sensíveis

| Dado | Criptografado | Armazenamento |
|------|---------------|---------------|
| PIN | ✅ | Secure Storage |
| Dados biométricos | ❌ | Nunca armazenados |
| Perfil | ❌ | Hive (não sensível) |
| Contatos | ❌ | Hive (não sensível) |

---

## O que NÃO Fazemos

| # | Não Fazemos | Justificativa |
|---|------------|---------------|
| 1 | Armazenar dados biométricos | Privacidade |
| 2 | Enviar dados para analytics | Privacidade |
| 3 | Utilizar Firebase | Privacidade |
| 4 | Rastrear comportamento | Privacidade |
| 5 | Compartilhar com terceiros | Privacidade |

---

## Documentos Relacionados

- [13_SecurityArchitecture.md](./13_SecurityArchitecture.md)
- [08_LocalStorage.md](./08_LocalStorage.md)
- [13_Privacy.md](../03_Product/13_Privacy.md)
