# Performance

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Metas de Performance

| Métrica | Meta | Status |
|---------|------|--------|
| Inicialização | < 2 segundos | A validar |
| QR Code (geração) | < 1 segundo | A validar |
| QR Code (leitura) | < 3 segundos | A validar |
| NFC (compartilhamento) | < 5 segundos | A validar |
| FPS | ≥ 60 FPS | A validar |
| Troca de tema | < 500ms | A validar |
| Troca de idioma | < 500ms | A validar |

---

## Estratégias de Performance

### 1. Lazy Loading
```dart
// Carregar apenas quando necessário
final profile = ref.watch(profileProvider);
```

### 2. Const Widgets
```dart
// ✅ CORRETO
const Text('VCardSmart')

// ❌ INCORRETO
Text('VCardSmart')
```

### 3. Rebuild Mínimo
```dart
// ✅ CORRETO - Watches apenas o necessário
final name = ref.watch(profileProvider.select((p) => p?.name));

// ❌ INCORRETO - Watch no objeto inteiro
final profile = ref.watch(profileProvider);
```

### 4. caching
```dart
// Cache de dados que não mudam frequentemente
final profile = useMemoizer(() => getProfile());
```

---

## Otimizações

| Área | Otimização |
|------|-----------|
| **UI** | Const widgets, rebuild mínimo |
| **Dados** | Hive (rápido), cache |
| **Imagens** | Compressão, cache |
| **Navegação** | GoRouter (declarativo) |
| **Estado** | Riverpod (eficiente) |

---

## Medição

### Ferramentas
| Ferramenta | Uso |
|-----------|-----|
| Flutter DevTools | Performance geral |
| Timeline | Frames perdidos |
| Memory | Uso de memória |

### Comandos
```bash
# Profiling
flutter run --profile

# Análise de performance
flutter analyze --performance
```

---

## Problemas Comuns

| Problema | Solução |
|----------|---------|
| Frames perdidos | Reduzir rebuilds |
| Alto uso de memória | Liberar recursos |
| Inicialização lenta | Lazy loading |
| UI travando | Isolados para processamento |

---

## Documentos Relacionados

- [01_ArchitectureOverview.md](./01_ArchitectureOverview.md)
- [19_Performance.md](./19_Performance.md)
- [10_NonFunctionalRequirements.md](../03_Product/10_NonFunctionalRequirements.md)
