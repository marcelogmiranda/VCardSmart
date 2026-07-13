# Coding Standards

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Limites

| Elemento | Limite |
|----------|--------|
| **Arquivo** | Máximo 300 linhas |
| **Método** | Máximo 40 linhas |
| **Classe** | Máximo 500 linhas |

---

## Regras

| # | Regra |
|---|-------|
| 1 | Um arquivo por classe |
| 2 | Máximo 300 linhas por arquivo |
| 3 | Métodos até 40 linhas |
| 4 | Classes até 500 linhas |
| 5 | Sem comentários desnecessários |
| 6 | Documentação DartDoc obrigatória em APIs públicas |

---

## Documentação DartDoc

### Obrigatória em:
- Classes públicas
- Métodos públicos
- Propriedades públicas

### Não obrigatória em:
- Métodos privados
- Variáveis locais
- Parâmetros óbvios

### Exemplo
```dart
/// Salva o perfil do usuário no Hive.
///
/// [profile] é o perfil a ser salvo.
/// Retorna [Future<void>] quando completado.
Future<void> saveProfile(UserProfile profile) async {
  // ...
}
```

---

## Comentários

### ❌ INCORRETO
```dart
// Salvar perfil
final profile = await repository.getProfile();
```

### ✅ CORRETO
```dart
final profile = await repository.getProfile();
```

---

## Formatação

```bash
# Formatar código
dart format .

# Verificar erros
flutter analyze
```

---

## Documentos Relacionados

- [01_DevelopmentGuide.md](./01_DevelopmentGuide.md)
- [05_NamingConvention.md](./05_NamingConvention.md)
