# Testes de Aceitação do Usuário — VCardSmart

## Objetivo

Validar que o aplicativo atende às expectativas do usuário final em termos de funcionalidade, usabilidade e experiência.

## Fluxo

```
Definição de Critérios → Execução → Validação → Aprovação
```

## Critérios de Aceitação

### 1. Perfil

| ID | Critério | Prioridade |
|----|----------|------------|
| UAT-01 | Posso criar meu perfil em menos de 2 minutos | P0 |
| UAT-02 | Posso editar meu perfil a qualquer momento | P0 |
| UAT-03 | Meus dados estão seguros | P0 |
| UAT-04 | Posso acessar meu perfil offline | P1 |

### 2. Compartilhamento

| ID | Critério | Prioridade |
|----|----------|------------|
| UAT-05 | Posso compartilhar via QR Code | P0 |
| UAT-06 | Posso compartilhar via NFC | P0 |
| UAT-07 | Posso compartilhar via vCard | P0 |
| UAT-08 | O compartilhamento é rápido (< 3s) | P1 |

### 3. Contatos

| ID | Critério | Prioridade |
|----|----------|------------|
| UAT-09 | Posso importar contatos da agenda | P1 |
| UAT-10 | Posso exportar para a agenda | P1 |
| UAT-11 | Posso salvar contatos recebidos | P1 |

### 4. Configurações

| ID | Critério | Prioridade |
|----|----------|------------|
| UAT-12 | Posso mudar o tema | P2 |
| UAT-13 | Posso mudar o idioma | P2 |
| UAT-14 | Posso configurar biometria | P1 |
| UAT-15 | Posso configurar PIN | P1 |

### 5. Usabilidade

| ID | Critério | Prioridade |
|----|----------|------------|
| UAT-16 | O app é intuitivo | P0 |
| UAT-17 | O app responde rápido | P0 |
| UAT-18 | O app funciona offline | P0 |
| UAT-19 | O app é acessível | P1 |

## Casos de Teste

### UAT-01: Criar Perfil Rapidamente

```dart
void main() {
  group('UAT: Create Profile', () {
    testWidgets('user can create profile in under 2 minutes', ($) async {
      final stopwatch = Stopwatch()..start();
      
      await $.pumpApp(HomeScreen());
      
      // Criar perfil
      await $.tap(find.byKey(Key('create_profile_button')));
      await $.pumpAndSettle();
      
      await $.enterText(find.byKey(Key('name_field')), 'João Silva');
      await $.enterText(find.byKey(Key('email_field')), 'joao@email.com');
      await $.enterText(find.byKey(Key('phone_field')), '+5511999999999');
      await $.enterText(find.byKey(Key('company_field')), 'Empresa LTDA');
      
      await $.tap(find.byKey(Key('save_button')));
      await $.pumpAndSettle();
      
      stopwatch.stop();
      
      // Verificar tempo
      expect(
        stopwatch.elapsedMilliseconds,
        lessThan(120000), // 2 minutos
        reason: 'Profile creation should take less than 2 minutes',
      );
      
      // Verificar perfil criado
      expect(find.text('João Silva'), findsOneWidget);
    });
  });
}
```

### UAT-05: Compartilhar QR Code

```dart
group('UAT: Share QR Code', () {
  testWidgets('user can share via QR code easily', ($) async {
    await $.pumpApp(HomeScreen());
    
    // Gerar QR
    await $.tap(find.byKey(Key('qrcode_button')));
    await $.pumpAndSettle();
    
    // Verificar QR visível
    expect(find.byType(QrImage), findsOneWidget);
    
    // Compartilhar
    await $.tap(find.byKey(Key('share_button')));
    await $.pumpAndSettle();
    
    // Verificar opções de compartilhamento
    expect(find.text('Salvar Imagem'), findsOneWidget);
    expect(find.text('Compartilhar'), findsOneWidget);
  });
});
```

### UAT-16: App Intuitivo

```dart
group('UAT: Usability', () {
  testWidgets('user can navigate without instructions', ($) async {
    await $.pumpApp(HomeScreen());
    
    // Verificar elementos claros
    expect(find.byKey(Key('create_profile_button')), findsOneWidget);
    expect(find.byKey(Key('qrcode_button')), findsOneWidget);
    expect(find.byKey(Key('nfc_button')), findsOneWidget);
    expect(find.byKey(Key('settings_button')), findsOneWidget);
    
    // Verificar labels claros
    expect(find.text('Criar Perfil'), findsOneWidget);
    expect(find.text('QR Code'), findsOneWidget);
    expect(find.text('NFC'), findsOneWidget);
    expect(find.text('Configurações'), findsOneWidget);
  });
});
```

## Formulário de Validação

### Para Testadores

| Pergunta | Sim | Não | Observações |
|----------|-----|-----|-------------|
| Conseguiu criar perfil? | ☐ | ☐ | |
| Conseguiu compartilhar? | ☐ | ☐ | |
| O app é intuitivo? | ☐ | ☐ | |
| O app é rápido? | ☐ | ☐ | |
| O app funciona offline? | ☐ | ☐ | |
| Recomendaria o app? | ☐ | ☐ | |

### Notas

| Aspecto | Nota (1-5) | Observações |
|---------|------------|-------------|
| Facilidade de uso | | |
| Design | | |
| Performance | | |
| Confiabilidade | | |
| Acessibilidade | | |

## Processo

1. **Selecionar testadores** — Usuários representativos
2. **Preparar ambiente** — Devices, dados, cenários
3. **Executar testes** — Seguir script
4. **Coletar feedback** — Formulário + observação
5. **Analisar resultados** — Identificar padrões
6. **Priorizar correções** — Baseado em severidade
7. **Aprovar/rejeitar** — Decisão de release

## Métricas

| Métrica | Meta |
|---------|------|
| Critérios atendidos | 100% |
| Nota média usabilidade | ≥ 4.0/5.0 |
| Taxa de recomendação | ≥ 80% |
| Bugs críticos encontrados | 0 |
| Bugs médios encontrados | < 3 |
