# Splash Screen — VCardSmart

## Especificações

### Geral

| Campo | Valor |
|-------|-------|
| Resolução | 1080x1920 |
| Formato | PNG |
| Tema | Claro + Escuro |
| Duração | 1-2 segundos |

### Android

| Campo | Valor |
|-------|-------|
| API mínima | 21 (Android 5.0) |
| API alvo | 34 (Android 14) |
| Tipo | Splash Screen API |

### iOS

| Campo | Valor |
|-------|-------|
| iOS mínimo | 12.0 |
| Tipo | Launch Screen |

## Layout

### Estrutura

```
+--------------------------------------------------+
|                                                    |
|                                                    |
|                                                    |
|                  [LOGO]                           |
|                                                    |
|                  [NOME]                           |
|                                                    |
|                                                    |
|                                                    |
+--------------------------------------------------+
```

### Elementos

| Elemento | Posição | Tamanho |
|----------|---------|---------|
| Logo | Centro | 200x200 |
| Nome | Abaixo do logo | Variável |

## Tema Claro

### Cores

| Elemento | Cor |
|----------|-----|
| Fundo | #FFFFFF |
| Logo | #1976D2 |
| Nome | #212121 |

### Especificações

| Campo | Valor |
|-------|-------|
| Fundo | Branco sólido |
| Logo | Azul primário |
| Nome | Preto |

## Tema Escuro

### Cores

| Elemento | Cor |
|----------|-----|
| Fundo | #121212 |
| Logo | #1976D2 |
| Nome | #FFFFFF |

### Especificações

| Campo | Valor |
|-------|-------|
| Fundo | Preto sólido |
| Logo | Azul primário |
| Nome | Branco |

## Animação

### Regras

1. **Nunca** usar animação longa
2. **Nunca** usar efeitos complexos
3. **Sempre** transição suave
4. **Sempre** duração curta (1-2s)

### Comportamento

| Estado | Ação |
|--------|------|
| Início | Exibir splash |
| Carregando | Manter splash |
| Pronto | Transição suave para home |

## Implementação

### Android

```kotlin
// themes.xml
<style name="Theme.VCardSmart.Splash" parent="Theme.SplashScreen">
    <item name="windowSplashScreenBackground">@color/white</item>
    <item name="windowSplashScreenAnimatedIcon">@drawable/ic_launcher_foreground</item>
    <item name="windowSplashScreenAnimationDuration">1000</item>
</style>
```

### iOS

```swift
// LaunchScreen.storyboard
- Background: White
- Logo: Centered
- Constraints: Center X, Center Y
```

## Regras

### Geral

1. **Sempre** manter simplicidade
2. **Nunca** usar textos explicativos
3. **Sempre** usar cores oficiais
4. **Nunca** usar efeitos especiais

### Logo

1. **Sempre** centralizar
2. **Nunca** distorcer
3. **Sempre** usar resolução adequada
4. **Nunca** adicionar efeitos

### Nome

1. **Sempre** usar nome oficial
2. **Nunca** usar variações
3. **Sempre** manter legibilidade
4. **Nunca** usar fonte decorativa

## Produção

### Ferramentas

| Ferramenta | Uso |
|------------|-----|
| Figma | Design |
| Android Studio | Implementação Android |
| Xcode | Implementação iOS |

### Processo

1. Criar design no Figma
2. Exportar assets
3. Implementar no Android
4. Implementar no iOS
5. Testar em diferentes dispositivos
6. Documentar

## Revisão

### Checklist

- [ ] Resolução correta
- [ ] Tema claro configurado
- [ ] Tema escuro configurado
- [ ] Logo centralizado
- [ ] Nome legível
- [ ] Animação curta
- [ ] Transição suave
- [ ] Funciona em diferentes dispositivos
