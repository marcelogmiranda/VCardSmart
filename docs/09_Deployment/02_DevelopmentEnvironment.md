# Ambiente de Desenvolvimento — VCardSmart

## Sistemas Operacionais Suportados

| SO | Versão | Status |
|----|--------|--------|
| Windows | 11 | ✅ Suportado |
| macOS | Ventura+ | ✅ Suportado |
| Ubuntu | LTS | ✅ Suportado |

## Ferramentas Necessárias

### Essenciais

| Ferramenta | Versão Mínima | Instalação |
|------------|---------------|------------|
| Flutter SDK | 3.x Stable | flutter.dev |
| Dart SDK | Incluído no Flutter | - |
| Git | 2.x | git-scm.com |

### Android

| Ferramenta | Versão | Instalação |
|------------|--------|------------|
| Android Studio | Latest | developer.android.com |
| Android SDK | API 34+ | via Android Studio |
| Android Build Tools | 34+ | via Android Studio |
| Android Emulator | Latest | via Android Studio |

### iOS (apenas macOS)

| Ferramenta | Versão | Instalação |
|------------|--------|------------|
| Xcode | 15+ | Mac App Store |
| CocoaPods | 1.x | gem install cocoapods |
| iOS Simulator | incluído no Xcode | - |

## Verificação do Ambiente

```bash
# Verificar todas as dependências
flutter doctor

# Saída esperada:
# [✓] Flutter (Channel stable, 3.x)
# [✓] Android toolchain
# [✓] Xcode (iOS)
# [✓] Connected device
# [✓] HTTP Host Availability
```

## Estrutura do Ambiente

```
~/
├── flutter/                    # Flutter SDK
├── Android/
│   └── Sdk/                   # Android SDK
├── Xcode/                     # iOS (macOS)
├── .pub-cache/                # Cache do Dart
└── .flutter-plugins/          # Plugins Flutter
```

## Variáveis de Ambiente

### Android

```bash
# .bashrc ou .zshrc
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
```

### iOS

```bash
# Não requer configuração extra
# Xcode handles everything
```

## Verificação por Plataforma

### Windows

```powershell
flutter doctor
flutter doctor -v  # Verbose
```

### macOS

```bash
flutter doctor
flutter doctor -v
xcodebuild -version
pod --version
```

### Ubuntu

```bash
flutter doctor
flutter doctor -v
sudo apt-get install -y clang cmake ninja-build pkg-config
```

## Troubleshooting

| Problema | Solução |
|----------|---------|
| Flutter não encontrado | Adicionar ao PATH |
| Android SDK não encontrado | Instalar Android Studio |
| iOS certificates | Configurar no Xcode |
| CocoaPods errors | `pod repo update` |
| Emulator não inicia | Verificar Hyper-V/KVM |
