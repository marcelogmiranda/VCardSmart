# Package Standards

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Pacotes Permitidos

| Pacote | Versão | Uso |
|--------|--------|-----|
| flutter_riverpod | 2.x | Gerenciamento de estado |
| go_router | 12.x | Navegação |
| hive | 2.x | Banco de dados |
| hive_flutter | 1.x | Inicialização Hive |
| flutter_secure_storage | 9.x | Armazenamento seguro |
| flutter_contacts | 1.x | Agenda de contatos |
| mobile_scanner | 5.x | Leitura de QR Code |
| nfc_manager | 3.x | NFC |
| local_auth | 2.x | Biometria |
| google_mobile_ads | 5.x | Anúncios |
| share_plus | 10.x | Compartilhamento |
| url_launcher | 6.x | Abrir URLs |

---

## Pacotes NÃO Permitidos

| Pacote | Motivo |
|--------|--------|
| **Firebase** | Viola princípio offline |
| **SQLite** | Hive é o banco escolhido |
| **GetX** | Acoplamento excessivo |
| **MobX** | Complexidade desnecessária |
| **Bloc** | Complexidade desnecessária |
| **Provider** | Riverpod é o sucessor |
| **Realm** | Complexidade desnecessária |
| **dio** | Não necessário (offline) |
| **http** | Não necessário (offline) |
| **analytics** | Viola privacidade |

---

## Adição de Novos Pacotes

### Processo
1. Justificar necessidade
2. Verificar compatibilidade
3. Aprovar no team
4. Documentar no ADR
5. Adicionar ao pubspec.yaml

### Critérios de Aprovação
- ✅ Compatível com Flutter
- ✅ Compatível com Android e iOS
- ✅ Ativo e mantido
- ✅ Sem dependências de cloud
- ✅ Sem analytics
- ✅ Licença compatível

---

## Versões

| Pacote | Versão Mínima | Versão Recomendada |
|--------|--------------|-------------------|
| flutter_riverpod | 2.0.0 | 2.5.0 |
| go_router | 12.0.0 | 14.0.0 |
| hive | 2.0.0 | 2.2.3 |
| hive_flutter | 1.0.0 | 1.1.0 |

---

## Documentos Relacionados

- [01_ArchitectureOverview.md](./01_ArchitectureOverview.md)
- [21_ArchitectureDecisionRecords.md](./21_ArchitectureDecisionRecords.md)
