# App Icon — VCardSmart

## Especificações

### Android

| Campo | Valor |
|-------|-------|
| Resolução | 512x512 |
| Formato | PNG |
| Tamanho máximo | 1MB |
| Tipo | Adaptive Icon |

### iOS

| Campo | Valor |
|-------|-------|
| Resolução | 1024x1024 |
| Formato | PNG |
| Tamanho máximo | 10MB |
| Tipo | App Icon |

## Design

### Conceito

- **Elemento principal**: "V" estilizado
- **Elemento secundário**: QR Code sutil ao fundo
- **Cor**: Azul (#1976D2)
- **Fundo**: Gradiente azul escuro

### Estrutura

```
+--------------------------------------------------+
|                                                    |
|                    [V]                            |
|                                                    |
|              [QR CODE SUTIL]                      |
|                                                    |
+--------------------------------------------------+
```

### Elementos

| Elemento | Descrição |
|----------|-----------|
| "V" | Letra V estilizada, centralizada |
| QR Code | Padrão sutil ao fundo |
| Fundo | Gradiente azul (#1976D2 → #1565C0) |

## Cores

### Paleta

| Cor | Código | Uso |
|-----|--------|-----|
| Azul primário | #1976D2 | Elemento principal |
| Azul escuro | #1565C0 | Gradiente fundo |
| Branco | #FFFFFF | Elemento "V" |

### Gradiente

```
De: #1976D2
Para: #1565C0
Direção: Topo → Base
```

## Adaptive Icon

### Android

#### Camadas

| Camada | Conteúdo |
|--------|----------|
| Foreground | "V" estilizado + QR Code |
| Background | Gradiente azul |

#### Especificações

| Campo | Valor |
|-------|-------|
| Tamanho | 108x108dp |
| Zona segura | 66x66dp (centro) |
| Padding | 21dp (bordas) |

#### Regras

1. **Nunca** usar texto
2. **Nunca** usar bordas
3. **Sempre** fundo sólido
4. **Sempre** centralizar elemento principal

### iOS

#### Especificações

| Campo | Valor |
|-------|-------|
| Tamanho | 1024x1024px |
| Formato | PNG |
| Cor | RGB 8-bit |
| Alpha | Sem transparência |

#### Regras

1. **Nunca** usar transparência
2. **Nunca** usar arredondamento (sistema aplica)
3. **Sempre** fundo sólido
4. **Sempre** resolução completa

## Regras Gerais

### Design

1. **Nunca** usar texto no ícone
2. **Nunca** usar bordas coloridas
3. **Sempre** fundo sólido
4. **Sempre** reconhecimento imediato
5. **Nunca** usar efeitos especiais

### Cores

1. **Sempre** usar cores oficiais
2. **Nunca** usar cores não autorizadas
3. **Sempre** manter contraste
4. **Nunca** usar gradiente complexo

### Tamanho

1. **Sempre** usar resolução adequada
2. **Nunca** esticar ou comprimir
3. **Sempre** manter proporção
4. **Nunca** approximation

## Variações

### Tema Claro

- Fundo: Gradiente azul
- Elemento: Branco
- Contraste: Alto

### Tema Escuro

- Fundo: Gradiente azul escuro
- Elemento: Branco
- Contraste: Alto

### Monochrome

- Fundo: Preto
- Elemento: Branco
- Uso: contexts específicos

## Produção

### Ferramentas

| Ferramenta | Uso |
|------------|-----|
| Figma | Design |
| Adobe Illustrator | Vetores |
| Android Studio | Adaptive Icon |
| Xcode | iOS Icon |

### Processo

1. Criar design em SVG
2. Exportar para PNG em diversas resoluções
3. Criar Adaptive Icon (Android)
4. Configurar iOS Icon
5. Testar em diferentes fundos
6. Documentar

## Revisão

### Checklist

- [ ] Resolução correta
- [ ] Sem texto
- [ ] Sem bordas
- [ ] Fundo sólido
- [ ] Cores oficiais
- [ ] Reconhecimento imediato
- [ ] Funciona em diferentes fundos
- [ ] Adaptive Icon configurado (Android)
- [ ] iOS Icon configurado
