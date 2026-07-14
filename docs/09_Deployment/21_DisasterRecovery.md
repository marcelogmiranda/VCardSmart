# Disaster Recovery — VCardSmart

## Cenário: Perda do Dispositivo

### Fluxo

```
Perda do Dispositivo
    ↓
Reinstalação do App
    ↓
Novo Cadastro
    ↓
Sem Recuperação
```

### Detalhamento

| Etapa | Descrição |
|-------|-----------|
| Perda | Dispositivo perdido ou roubado |
| Reinstalação | Usuário instala app em novo dispositivo |
| Novo cadastro | Usuário cria novo perfil |
| Sem recuperação | Dados anteriores não são recuperáveis |

## Por que Sem Recuperação?

### Política de Privacidade

1. **Sem Backup em Cloud** — Dados nunca saem do dispositivo
2. **Sem Sincronização** — Sem conta obrigatória
3. **Sem Analytics** — Sem rastreamento de usuários
4. **Privacidade Total** — Dados 100% locais

### Benefícios

- Zero risco de vazamento de dados
- Sem dependência de servidores
- Compliance total com LGPD/GDPR
- Usuário tem controle total

### Limitações

- Dados não são recuperáveis
- Usuário deve estar ciente
- Nova conta necessária em novo dispositivo

## Comunicação com o Usuário

### Na Primeira Utilização

```dart
void showFirstUseWarning() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Dados Locais'),
      content: Text(
        'Seus dados são armazenados apenas neste dispositivo. '
        'Se você perder ou trocar de dispositivo, seus dados '
        'não poderão ser recuperados. Recomendamos manter '
        'uma cópia dos seus dados em local seguro.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Entendi'),
        ),
      ],
    ),
  );
}
```

### Opção de Exportação

```dart
void showExportOption() {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Exportar Dados'),
      content: Text(
        'Você pode exportar seus dados para manter uma cópia de segurança.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Agora Não'),
        ),
        ElevatedButton(
          onPressed: () => exportData(),
          child: Text('Exportar'),
        ),
      ],
    ),
  );
}
```

## Exportação de Dados

### Opções

| Formato | Descrição | Uso |
|---------|-----------|-----|
| vCard | Formato padrão | Backup manual |
| JSON | Formato completo | Backup técnico |
| PDF | Formato visual | Backup impresso |

### Implementação

```dart
Future<void> exportData() async {
  final profile = await getCurrentProfile();
  
  // Gerar vCard
  final vcard = VCardGenerator.generate(profile);
  
  // Compartilhar
  await Share.share(vcard, subject: 'Backup VCardSmart');
}
```

## Restauração

### Não há restauração automática

O usuário deve:

1. Criar novo perfil
2. Preencher dados manualmente
3. Ou importar vCard exportada anteriormente

### Fluxo de Restauração

```
Instalar App
    ↓
Criar Perfil
    ↓
Importar vCard (se disponível)
    ↓
Dados restaurados (parcialmente)
```

## Documentação

### Para o Usuário

```markdown
## Seus Dados

O VCardSmart armazena seus dados apenas neste dispositivo.
Isso significa que:

- ✅ Seus dados são 100% privados
- ✅ Nenhum dado sai do seu dispositivo
- ✅ Você tem controle total

⚠️ No entanto, se você perder ou trocar de dispositivo:
- ❌ Seus dados não poderão ser recuperados
- ❌ Você precisará criar uma nova conta

### Recomendação

Exporte seus dados regularmente:
1. Acesse Configurações
2. Selecione "Exportar Dados"
3. Escolha o formato (vCard ou JSON)
4. Salve em local seguro
```

## Compliance

- LGPD: Dados permanecem com o titular
- GDPR: Right to portability (exportação)
- Sem sharing com terceiros
- Sem backup em cloud
- Zero analytics
