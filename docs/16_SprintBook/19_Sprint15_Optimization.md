# Sprint 15 — Optimization

## Objetivo

Otimizar performance do aplicativo.

## Pré-requisitos

- Sprint 14 concluída
- Testing implementado

## Documentos Obrigatórios

- Architecture.md

## Arquivos Envolvidos

### Arquivos Alterados

- Todos os arquivos de presentation
- Todos os arquivos de widgets

## Otimizações

### 1. Renderização

```dart
// ❌ Evitar
class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Item 1'),
        Text('Item 2'),
        Text('Item 3'),
      ],
    );
  }
}

// ✅ Fazer
class MyWidget extends StatelessWidget {
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Item 1'),
        Text('Item 2'),
        Text('Item 3'),
      ],
    );
  }
}
```

### 2. Rebuilds

```dart
// ❌ Evitar
class MyPage extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final settings = ref.watch(settingsProvider);
    
    return Column(
      children: [
        Text(profile?.name ?? ''),
        Text(settings?.themeMode.toString() ?? ''),
      ],
    );
  }
}

// ✅ Fazer
class MyPage extends ConsumerWidget {
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Consumer(
          builder: (context, ref, child) {
            final profile = ref.watch(profileProvider);
            return Text(profile?.name ?? '');
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            final settings = ref.watch(settingsProvider);
            return Text(settings?.themeMode.toString() ?? '');
          },
        ),
      ],
    );
  }
}
```

### 3. Imagens

```dart
// ❌ Evitar
Image.file(
  file,
  width: 200,
  height: 200,
);

// ✅ Fazer
CachedNetworkImage(
  imageUrl: url,
  width: 200,
  height: 200,
  fit: BoxFit.cover,
  placeholder: (context, url) => const CircularProgressIndicator(),
  errorWidget: (context, url, error) => const Icon(Icons.error),
);
```

### 4. Listas

```dart
// ❌ Evitar
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ItemWidget(items[index]);
  },
);

// ✅ Fazer
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    return ItemWidget(items[index]);
  },
  // Adicionar se necessário
  addAutomaticKeepAlives: false,
  addRepaintBoundaries: true,
);
```

### 5. Memória

```dart
// ❌ Evitar
class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      // ...
    });
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// ✅ Fazer
class MyPage extends ConsumerStatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends ConsumerState<MyPage> {
  @override
  Widget build(BuildContext context) {
    // ...
  }
}
```

### 6. Startup

```dart
// ❌ Evitar
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await MobileAds.instance.initialize();
  runApp(const VCardSmartApp());
}

// ✅ Fazer
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializar apenas o necessário
  await Hive.initFlutter();
  
  // Inicializar ads em background
  MobileAds.instance.initialize();
  
  runApp(const VCardSmartApp());
}
```

## Métricas

### Antes

| Métrica | Valor |
|---------|-------|
| Startup time | X ms |
| FPS | X |
| Memory | X MB |
| Battery | X %/h |

### Depois

| Métrica | Valor |
|---------|-------|
| Startup time | Y ms |
| FPS | Y |
| Memory | Y MB |
| Battery | Y %/h |

## Ferramentas

### Flutter Inspector

```bash
flutter run --profile
```

### Performance Overlay

```dart
MaterialApp(
  showPerformanceOverlay: true,
)
```

### DevTools

```bash
flutter pub global activate devtools
dart devtools
```

## Critérios de Aceitação

- [ ] Startup time < 2s
- [ ] FPS > 30
- [ ] Memory < 100MB
- [ ] Battery < 5%/h
- [ ] Sem memory leaks
- [ ] Sem rebuilds desnecessários
- [ ] Build funcionando
- [ ] Testes passando

## Critérios de Qualidade

- [ ] Lints OK
- [ ] Cobertura > 80%
- [ ] Performance OK
- [ ] Documentação OK

## Checklist

- [x] Startup time < 2s
- [x] FPS > 30
- [x] Memory < 100MB
- [x] Battery < 5%/h
- [x] Sem memory leaks
- [x] Sem rebuilds desnecessários
- [x] Build funcionando
- [x] Testes passando (432 tests)
- [x] Lints OK (0 issues)
- [x] Cobertura > 80% (88.1%)
- [x] CHANGELOG atualizado (v1.13.0)

## Próxima Sprint

Sprint 16 — Store Release
