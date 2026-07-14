# Textos Multilíngues — VCardSmart

## Idiomas Suportados

| Código | Idioma | Status |
|--------|--------|--------|
| pt-BR | Português (Brasil) | ✅ Nativo |
| en | English | ✅ Traduzido |
| es | Español | ✅ Traduzido |
| fr | Français | ✅ Traduzido |
| it | Italiano | ✅ Traduzido |
| de | Deutsch | ✅ Traduzido |
| ja | 日本語 | ✅ Traduzido |
| zh | 中文 | ✅ Traduzido |

## Textos da Store

### Título

| Idioma | Título |
|--------|--------|
| pt-BR | VCardSmart - Cartão de Visitas Digital Offline |
| en | VCardSmart - Offline Digital Business Card |
| es | VCardSmart - Tarjeta de Presentación Digital Offline |
| fr | VCardSmart - Carte de Visite Numérique Hors Ligne |
| it | VCardSmart - Biglietto da Visita Digitale Offline |
| de | VCardSmart - Offline-Digitaler Visitenkarte |
| ja | VCardSmart - オフラインデジタル名刺 |
| zh | VCardSmart - 离线数字名片 |

### Subtítulo

| Idioma | Subtítulo |
|--------|-----------|
| pt-BR | Cartão de Visitas Digital Offline |
| en | Offline Digital Business Card |
| es | Tarjeta de Presentación Digital Offline |
| fr | Carte de Visite Numérique Hors Ligne |
| it | Biglietto da Visita Digitale Offline |
| de | Offline-Digitaler Visitenkarte |
| ja | オフラインデジタル名刺 |
| zh | 离线数字名片 |

### Descrição Curta

| Idioma | Descrição |
|--------|-----------|
| pt-BR | Cartão de visitas digital offline. QR Code, NFC, vCard. Sem login, sem nuvem, sem rastreamento. |
| en | Offline digital business card. QR Code, NFC, vCard. No login, no cloud, no tracking. |
| es | Tarjeta de presentación digital offline. QR Code, NFC, vCard. Sin login, sin nube, sin rastreo. |
| fr | Carte de visite numérique hors ligne. QR Code, NFC, vCard. Pas de connexion, pas de cloud, pas de suivi. |
| it | Biglietto da visita digitale offline. QR Code, NFC, vCard. Nessun login, nessuna cloud, nessun tracciamento. |
| de | Offline-Digitaler Visitenkarte. QR Code, NFC, vCard. Kein Login, kein Cloud, kein Tracking. |
| ja | オフラインデジタル名刺。QR Code、NFC、vCard。ログイン不要、クラウド不要、トラッキングなし。 |
| zh | 离线数字名片。QR Code、NFC、vCard。无需登录、无需云、无需跟踪。 |

## Textos do Aplicativo

### Telas Principais

| Chave | pt-BR | en | es | fr | it | de | ja | zh |
|-------|-------|----|----|----|----|----|----|-----|
| home_title | Início | Home | Inicio | Accueil | Home Startseite | ホーム | 首页 | |
| profile_title | Meu Perfil | My Profile | Mi Perfil | Mon Profil | Il Mio Profilo | Mein Profil | マイプロフィール | 我的资料 |
| share_title | Compartilhar | Share | Compartir | Partager | Condividi | Teilen | 共有 | 分享 |
| import_title | Importar | Import | Importar | Importer | Importieren | インポート | 导入 | |
| settings_title | Configurações | Settings | Configuraciones | Paramètres | Impostazioni | Einstellungen | 設定 | 设置 |

### Ações

| Chave | pt-BR | en | es | fr | it | de | ja | zh |
|-------|-------|----|----|----|----|----|----|-----|
| save | Salvar | Save | Guardar | Sauvegarder | Salva | Speichern | 保存 | 保存 |
| cancel | Cancelar | Cancel | Cancelar | Annuler | Annulla | Abbrechen | キャンセル | 取消 |
| delete | Excluir | Delete | Eliminar | Supprimer | Elimina | Löschen | 削除 | 删除 |
| edit | Editar | Edit | Editar | Modifier | Modifica | Bearbeiten | 編集 | 编辑 |
| share | Compartilhar | Share | Compartir | Partager | Condividi | Teilen | 共有 | 分享 |

### Mensagens

| Chave | pt-BR | en | es | fr | it | de | ja | zh |
|-------|-------|----|----|----|----|----|----|-----|
| success | Sucesso! | Success! | ¡Éxito! | Succès! | Successo! | Erfolg! | 成功！ | 成功！ |
| error | Erro | Error | Error | Erreur | Errore | Fehler | エラー | 错误 |
| loading | Carregando... | Loading... | Cargando... | Chargement... | Caricamento... | Laden... | 読み込み中... | 加载中... |
| no_data | Sem dados | No data | Sin datos | Aucune donnée | Nessun dato | Keine Daten | データなし | 无数据 |

## Estrutura de Tradução

### Arquivos

```
lib/
├── l10n/
│   ├── app_pt.arb
│   ├── app_en.arb
│   ├── app_es.arb
│   ├── app_fr.arb
│   ├── app_it.arb
│   ├── app_de.arb
│   ├── app_ja.arb
│   └── app_zh.arb
```

### Formato ARB

```json
{
  "@@locale": "pt",
  "appTitle": "VCardSmart",
  "homeTitle": "Início",
  "@homeTitle": {
    "description": "Título da tela inicial"
  }
}
```

## Manutenção

### Processo

1. Atualizar textos em português (fonte)
2. Traduzir para idiomas suportados
3. Revisar traduções
4. Atualizar arquivos ARB
5. Testar em todos os idiomas

### Frequência

- Textos de Store: A cada atualização
- Textos do app: A cada nova funcionalidade
- Revisão: Semestral
