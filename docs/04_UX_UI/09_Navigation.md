# Navigation

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Fluxo Principal

```
Splash → Biometria → Home → Meu Cartão → Compartilhar → Configurações
```

---

## Navegação Inferior

```
┌──────────┬──────────┬──────────┐
│  Home    │ Cartões  │ Config   │
│  🏠      │  📋      │  ⚙️      │
└──────────┴──────────┴──────────┘
```

---

## Árvore de Navegação

```
Home
├── Meu Cartão
│     ├── Editar Perfil
│     ├── Editar Empresa
│     ├── Telefones
│     ├── Redes Sociais
│     └── Compartilhar
│           ├── QR Code
│           └── NFC
│
├── Cartões Recebidos
│     ├── Detalhes do Cartão
│     └── Salvar na Agenda
│
└── Configurações
      ├── Idioma
      ├── Tema
      ├── Segurança
      ├── Sugestões
      ├── Sobre
      └── Licenças
```

---

## Regras de Navegação

| # | Regra |
|---|-------|
| 1 | Sempre mostrar botão voltar em sub-rotas |
| 2 | Navegação consistente entre Android e iOS |
| 3 | Profundidade máxima de 4 níveis |
| 4 | Sem dead ends (sempre há como voltar) |
| 5 | Transições suaves entre telas |

---

## Transições

| Tipo | Uso | Duração |
|------|-----|---------|
| Slide | Navegação padrão | 300ms |
| Fade | Carregamento | 200ms |
| Scale | Detalhes | 250ms |
| Hero | Compartilhar | 300ms |

---

## Documentos Relacionados

- [09_Navigation.md](./09_Navigation.md)
- [06_Navigation.md](../04_Architecture/06_Navigation.md)
- [11_UserFlows.md](./11_UserFlows.md)
