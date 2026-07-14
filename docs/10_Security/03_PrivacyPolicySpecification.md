# Especificação da Política de Privacidade — VCardSmart

## Declaração de Privacidade

### O aplicativo VCardSmart:

| Afirmação | Status |
|-----------|--------|
| Não coleta dados | ✅ |
| Não envia dados | ✅ |
| Não compartilha dados | ✅ |
| Não possui servidor | ✅ |
| Não possui login | ✅ |
| Não utiliza cookies | ✅ |
| Não utiliza analytics | ✅ |
| Não utiliza telemetria | ✅ |
| Não utiliza Firebase | ✅ |
| Não utiliza Google Analytics | ✅ |
| Não utiliza Facebook SDK | ✅ |
| Não utiliza Crashlytics | ✅ |
| Não utiliza Push Notifications | ✅ |

## Política Técnica

### O que o aplicativo NUNCA irá:

1. **Criar conta** — Sem registro obrigatório
2. **Solicitar login** — Sem autenticação remota
3. **Utilizar e-mail** — Sem envio de emails
4. **Compartilhar informações** — Sem autorização explícita
5. **Acessar a internet** — Apenas para anúncios e atualização
6. **Sincronizar dados** — Sem backup em cloud
7. **Armazenar em servidores** — 100% local
8. **Utilizar SDKs de rastreamento** — Zero tracking
9. **Utilizar identificadores** — Sem perfilamento

### O que o aplicativo PODE fazer:

1. **Verificar atualização** — Apenas consultar versão na loja
2. **Exibir anúncios** — Google Mobile Ads (com consentimento)
3. **Solicitar permissões** — Apenas quando necessário
4. **Exportar dados** — Apenas com ação do usuário
5. **Importar dados** — Apenas com ação do usuário

## Modelo de Permissões

| Permissão | Obrigatória | Justificativa |
|-----------|-------------|---------------|
| Câmera | Sim | Leitura de QR Code |
| NFC | Opcional | Compartilhamento NFC |
| Contatos | Opcional | Salvar na agenda |
| Biometria | Opcional | Proteção do aplicativo |
| Internet | Sim | Apenas anúncios e atualização |

### Regras de Permissão

1. **Solicitação sob demanda** — Nunca preventiva
2. **Justificativa clara** — Usuário ciente do motivo
3. **Possibilidade de negar** — Funcionalidade alternativa
4. **Revogação permitida** — A qualquer momento

## Fluxo de Consentimento

### Compartilhamento

```
1. Usuário seleciona dados para compartilhar
2. Resumo exibido ao usuário
3. Confirmação solicitada
4. Payload gerado
5. Payload validado
6. Transmissão realizada
```

### Importação

```
1. Dados recebidos (QR/NFC/vCard)
2. Dados validados
3. Dados exibidos ao usuário
4. Confirmação de importação solicitada
5. Dados salvos apenas após confirmação
```

### Alteração na Agenda

```
1. Contato recebido
2. Contato comparado com existente
3. Diferenças exibidas
4. Confirmação de alteração solicitada
5. Contato atualizado apenas após confirmação
```

## Direitos do Usuário

### LGPD

| Direito | Implementação |
|---------|---------------|
| Acesso | Dados sempre acessíveis no dispositivo |
| Correção | Edição permitida a qualquer momento |
| Exclusão | Exclusão completa dos dados |
| Portabilidade | Exportação em vCard/JSON |
| Informação | Política de privacidade clara |
| Consentimento | Explícito e granular |

### Implementação

```dart
// Exportação de dados (Portabilidade)
Future<void> exportData() async {
  final profile = await getProfile();
  final vcard = VCardGenerator.generate(profile);
  await Share.share(vcard);
}

// Exclusão de dados
Future<void> deleteAllData() async {
  await showDialog(
    context: context,
    builder: (context) => ConfirmDialog(
      title: 'Excluir Todos os Dados',
      message: 'Esta ação é irreversível.',
      onConfirm: () async {
        await HiveService.deleteAll();
        await SecureStorageService.deleteAll();
      },
    ),
  );
}
```

## Cookies e Rastreamento

### Cookies

- ❌ Não utilizamos cookies
- ❌ Não utilizamos web views com cookies
- ❌ Não utilizamos sessões remotas

### Rastreamento

- ❌ Google Analytics
- ❌ Facebook Analytics
- ❌ Firebase Analytics
- ❌ Amplitude
- ❌ Mixpanel
- ❌ Qualquer SDK de rastreamento

### Anúncios

- ✅ Google Mobile Ads
- ❌ Personalização de anúncios
- ❌ Retargeting
- ❌ Behavioral targeting

## Atualizações da Política

### Notificação

- Notificação in-app de mudanças
- Versão da política visível
- Data da última atualização

### Mudanças Material

- Consentimento renovação
- Notificação proativa
- Possibilidade de recusa
