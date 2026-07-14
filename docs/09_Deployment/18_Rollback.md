# Rollback — VCardSmart

## Quando Fazer Rollback

- Bug crítico em produção
- Perda de dados do usuário
- Performance degradada
- Violação de política das lojas
- Vulnerabilidade de segurança

## Android

### Google Play

```bash
# Opção 1: Atualização rápida
# Publicar versão anterior corrigida

# Opção 2: Retirar versão
# Google Play Console → App → Production → Retirar versão
```

### Processo

1. Acessar Google Play Console
2. Selecionar o app
3. Ir para Production
4. Clicar em "Retirar versão"
5. Confirmar retirada
6. Publicar versão anterior (se necessário)

### Limitações

- Não é possível reutilizar números de versão
- Usuários com a versão problemática continuarão com ela
- Nova versão deve ter número maior

## iOS

### App Store

```bash
# Opção 1: Nova versão
# Publicar versão anterior corrigida

# Opção 2: Retirar versão
# App Store Connect → App → Versões → Retirar
```

### Processo

1. Acessar App Store Connect
2. Selecionar o app
3. Ir para iOS App → Versões
4. Selecionar versão problemática
5. Clicar em "Retirar do App Store"
6. Publicar versão anterior (se necessário)

### Limitações

- Retirada leva até 24h para efetivar
- Nova versão deve passar por revisão
- Não é possível reutilizar números de versão

## Rollback Parcial

### Feature Flag

```dart
// Desabilitar funcionalidade problemática
class FeatureFlags {
  static const bool nfcEnabled = false; // Desabilitado temporariamente
  static const bool qrCodeEnabled = true;
  static const bool adsEnabled = true;
}
```

### Remote Config

```dart
// Usar Firebase Remote Config
final config = await FirebaseRemoteConfig.instance.fetchAndActivate();
final nfcEnabled = config.getBool('nfc_enabled');
```

## Prevenção

### Rollout Gradual

```yaml
# Google Play
rollout:
  status: inProgress
  fraction: 10  # Começar com 10%

# App Store
# Usar Phased Release (7 dias)
```

### Monitoramento

```bash
# Monitorar após release
# - Crash reports
# - User feedback
# - Store reviews
# - Performance metrics
```

## Checklist de Rollback

- [ ] Bug identificado e confirmado
- [ ] Impacto avaliado
- [ ] Decisão de rollback tomada
- [ ] Comunicação preparada
- [ ] Versão anterior identificada
- [ ] Build da versão anterior disponível
- [ ] Publicação iniciada
- [ ] Usuários notificados
- [ ] Monitoramento intensificado
- [ ] Documentação atualizada

## Template de Comunicação

```markdown
## Rollback: VCardSmart vX.Y.Z

### Problema
[Descrição do problema]

### Impacto
[Usuários afetados]

### Ação
Retiramos a versão X.Y.Z do aplicativo.

### Solução
Estamos trabalhando em uma correção que será publicada em breve.

### Pedimos desculpas pelo inconveniente.
```
