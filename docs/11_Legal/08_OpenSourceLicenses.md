# Licenças Open Source — VCardSmart

## Política

Todas as dependências deverão possuir licenças compatíveis com distribuição comercial.

## Licenças Preferidas

| Licença | Descrição | Compatível |
|---------|-----------|------------|
| MIT | Permissiva | ✅ |
| BSD | Permissiva | ✅ |
| Apache 2.0 | Permissiva | ✅ |
| Flutter License | BSD | ✅ |
| ISC | Permissiva | ✅ |

## Licenças Incompatíveis

| Licença | Descrição | Compatível |
|---------|-----------|------------|
| GPL | Copyleft forte | ❌ |
| AGPL | Copyleft forte | ❌ |
| LGPL | Copyleft fraco | ⚠️ (caso a caso) |

## Verificação

### Comando

```bash
# Listar licenças
flutter pub deps --no-dev --style=compact

# Verificar licenças
dart pub deps
```

### Ferramenta

```yaml
# pubspec.yaml
dependencies:
  license_checker: ^1.0.0
```

### Uso

```dart
// Verificar licenças
final licenses = await LicenseChecker.check();
print(licenses);
```

## Registro de Licenças

### Formato

```json
{
  "package": "flutter",
  "version": "3.x",
  "license": "BSD",
  "compatible": true
}
```

### Estrutura

```
docs/
├── licenses/
│   ├── flutter.md
│   ├── hive.md
│   ├── riverpod.md
│   └── ...
└── ...
```

## Processo de Inclusão

### 1. Verificação

```bash
# Antes de incluir nova dependência
flutter pub outdated
dart pub deps
```

### 2. Análise

```dart
// Verificar licença
final license = await getLicense(package);
final compatible = isCompatible(license);

if (!compatible) {
  throw IncompatibleLicenseException();
}
```

### 3. Aprovação

```markdown
## Solicitação de Nova Dependência

**Pacote**: [nome]
**Versão**: [versão]
**Licença**: [licença]
**Uso**: [descrição do uso]
**Alternativas**: [outras opções consideradas]

### Análise de Licença

- [ ] Licença compatível
- [ ] Sem copyleft forte
- [ ] Manutenção ativa
- [ ] Histórico de segurança

### Aprovação

- [ ] Tech Lead
- [ ] QA
- [ ] PO
```

### 4. Documentação

```markdown
## Dependência Adicionada

**Pacote**: [nome]
**Versão**: [versão]
**Licença**: [licença]
**Data**: [data]
**Aprovado por**: [nome]
```

## Auditoria

### Frequência

- **Mensal**: Verificar atualizações
- **Trimestral**: Auditoria completa
- **Por release**: Verificação final

### Checklist

- [ ] Todas as licenças verificadas
- [ ] Nenhuma licença incompatível
- [ ] Licenças documentadas
- [ ] Atualizações aplicadas

## Exemplo de Licença

### MIT

```
MIT License

Copyright (c) [year] [copyright holder]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## ADR

**ADR-032**: Open Source Compliance

> Nenhuma biblioteca incompatível com distribuição comercial poderá ser utilizada.
