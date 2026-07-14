# Configuração VS Code — VCardSmart

## Extensões Obrigatórias

### Flutter/Dart

| Extensão | ID | Descrição |
|----------|-----|-----------|
| Flutter | `dart-code.flutter` | Suporte Flutter |
| Dart | `dart-code.dart` | Suporte Dart |

### Produtividade

| Extensão | ID | Descrição |
|----------|-----|-----------|
| Error Lens | `usernamehw.errorlens` | Erros inline |
| GitLens | `eamodio.gitlens` | Git avançado |
| Markdown All in One | `yzhang.markdown-all-in-one` | Markdown |
| Material Icon Theme | `PKief.material-icon-theme` | Ícones |
| Better Comments | `aaron-bond.better-comments` | Comentários |
| Code Spell Checker | `streetsidesoftware.code-spell-checker` | Ortografia |

### GitHub

| Extensão | ID | Descrição |
|----------|-----|-----------|
| GitHub Pull Requests | `github.vscode-pull-request-github` | PRs |
| YAML | `redhat.vscode-yaml` | YAML |

### AI

| Extensão | ID | Descrição |
|----------|-----|-----------|
| OpenCode | `opencode.opencode` | AI Assistant |

## Configuração

### settings.json

```json
{
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true,
    "source.organizeImports": true
  },
  "dart.lineLength": 80,
  "dart.runPubOnSave": true,
  "dart.flutterRunLogFile": "",
  "dart.analysisExcludedFolders": [
    "build",
    ".dart_tool",
    "android/app/build"
  ],
  "files.associations": {
    "*.arb": "json"
  },
  "files.trimTrailingWhitespace": true,
  "files.insertFinalNewline": true,
  "files.trimFinalNewlines": true,
  "[dart]": {
    "editor.defaultFormatter": "dart-code.dart-code",
    "editor.formatOnSave": true,
    "editor.selectionClipboard": true
  },
  "[json]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[yaml]": {
    "editor.defaultFormatter": "redhat.vscode-yaml"
  },
  "workbench.iconTheme": "material-icon-theme",
  "workbench.colorTheme": "Default Dark Modern"
}
```

### extensions.json

```json
{
  "recommendations": [
    "dart-code.flutter",
    "dart-code.dart",
    "usernamehw.errorlens",
    "eamodio.gitlens",
    "yzhang.markdown-all-in-one",
    "PKief.material-icon-theme",
    "aaron-bond.better-comments",
    "streetsidesoftware.code-spell-checker",
    "github.vscode-pull-request-github",
    "redhat.vscode-yaml",
    "opencode.opencode"
  ]
}
```

### launch.json

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter (Debug)",
      "type": "dart",
      "request": "launch",
      "program": "lib/main.dart",
      "flutterMode": "debug"
    },
    {
      "name": "Flutter (Profile)",
      "type": "dart",
      "request": "launch",
      "program": "lib/main.dart",
      "flutterMode": "profile"
    },
    {
      "name": "Flutter (Release)",
      "type": "dart",
      "request": "launch",
      "program": "lib/main.dart",
      "flutterMode": "release"
    },
    {
      "name": "Flutter (Test)",
      "type": "dart",
      "request": "launch",
      "program": "test/widget_test.dart"
    }
  ]
}
```

### tasks.json

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Flutter: Get Packages",
      "type": "shell",
      "command": "flutter",
      "args": ["pub", "get"],
      "group": "build"
    },
    {
      "label": "Flutter: Analyze",
      "type": "shell",
      "command": "flutter",
      "args": ["analyze"],
      "group": "test"
    },
    {
      "label": "Flutter: Test",
      "type": "shell",
      "command": "flutter",
      "args": ["test"],
      "group": "test"
    },
    {
      "label": "Flutter: Build APK",
      "type": "shell",
      "command": "flutter",
      "args": ["build", "apk"],
      "group": "build"
    },
    {
      "label": "Flutter: Build iOS",
      "type": "shell",
      "command": "flutter",
      "args": ["build", "ios"],
      "group": "build"
    },
    {
      "label": "Flutter: Clean",
      "type": "shell",
      "command": "flutter",
      "args": ["clean"],
      "group": "build"
    },
    {
      "label": "Flutter: Format",
      "type": "shell",
      "command": "dart",
      "args": ["format", "."],
      "group": "build"
    },
    {
      "label": "Flutter: Run Build Runner",
      "type": "shell",
      "command": "dart",
      "args": ["run", "build_runner", "build", "--delete-conflicting-outputs"],
      "group": "build"
    }
  ]
}
```

### keybindings.json

```json
[
  {
    "key": "ctrl+shift+f",
    "command": "editor.action.formatDocument"
  },
  {
    "key": "ctrl+shift+i",
    "command": "editor.action.organizeImports"
  }
]
```

## Atalhos Úteis

| Atalho | Ação |
|--------|------|
| `Ctrl+Shift+F` | Formatar documento |
| `Ctrl+Shift+I` | Organizar imports |
| `Ctrl+Shift+R` | Refactor |
| `F5` | Iniciar debugger |
| `Ctrl+Shift+P` | Command Palette |
| `Ctrl+` | Terminal |
