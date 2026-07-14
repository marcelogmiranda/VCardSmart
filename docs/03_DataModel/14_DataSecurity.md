# Data Security

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Camadas de Segurança

| Camada | Mecanismo | Descrição |
|--------|----------|-----------|
| **Acesso ao App** | Biometria / PIN | Autenticação antes de usar |
| **Armazenamento** | Hive AES | Criptografia de dados sensíveis |
| **Dados Críticos** | Secure Storage | PIN e tokens |
| **Compartilhamento** | Confirmação | Usuário autoriza cada ação |

---

## Hive Encryption

### Configuração
```dart
// Abrir box com criptografia AES
final encryptedBox = await Hive.openBox(
  'sensitiveData',
  encryptionCipher: HiveAesCipher(),
);
```

### Dados Criptografados
| Dado | Criptografado |
|------|---------------|
| PIN | ✅ |
| Dados sensíveis | ✅ |
| Perfil | ❌ |
| Configurações | ❌ |
| Contatos recebidos | ❌ |

---

## Secure Storage

### Uso
```dart
final secureStorage = FlutterSecureStorage();

// Salvar PIN
await secureStorage.write(key: 'pin', value: hashedPin);

// Ler PIN
final pin = await secureStorage.read(key: 'pin');

// Deletar PIN
await secureStorage.delete(key: 'pin');
```

---

## Biometria

### Implementação
```dart
final localAuth = LocalAuthentication();

// Verificar disponibilidade
final canAuth = await localAuth.canCheckBiometrics;

// Autenticar
final authenticated = await localAuth.authenticate(
  localizedReason: 'Autentique-se para acessar',
  options: const AuthenticationOptions(
    stickyAuth: true,
    biometricOnly: false,
  ),
);
```

---

## PIN

### Fluxo
```
Criar PIN → Hash → Salvar Secure Storage
    ↓
Validar PIN → Hash → Comparar
```

### Hash
```dart
String hashPin(String pin) {
  // Utilizar hash seguro (bcrypt, argon2, etc.)
  return bcrypt.hashpw(pin, bcrypt.gensalt());
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

## O que NÃO Fazemos

| # | Não Fazemos |
|---|------------|
| 1 | Armazenar dados biométricos |
| 2 | Enviar dados para analytics |
| 3 | Utilizar Firebase |
| 4 | Rastrear comportamento |
| 5 | Compartilhar com terceiros |

---

## Documentos Relacionados

- [13_SecurityArchitecture.md](../04_Architecture/13_SecurityArchitecture.md)
- [13_Privacy.md](../03_Product/13_Privacy.md)
- [08_LocalStorage.md](../04_Architecture/08_LocalStorage.md)
