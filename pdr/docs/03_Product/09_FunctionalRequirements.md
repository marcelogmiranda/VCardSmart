# Functional Requirements

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Legenda

| Prioridade | Significado |
|------------|-------------|
| P0 | Obrigatório para V1 |
| P1 | Desejável para V1 |
| P2 | Futuro |

---

## 1. Cadastro e Perfil

| ID | Requisito | Prioridade | Feature | Critério |
|----|-----------|------------|---------|----------|
| RF001 | Cadastrar perfil completo | P0 | F01 | AC001 |
| RF002 | Editar perfil existente | P0 | F01 | AC001 |
| RF003 | Excluir perfil | P0 | F01 | - |
| RF004 | Adicionar foto pessoal | P1 | F01 | AC001 |
| RF005 | Adicionar logotipo da empresa | P1 | F01 | AC001 |
| RF006 | Adicionar múltiplos telefones | P0 | F01 | AC001 |
| RF007 | Definir telefone principal | P0 | F01 | AC001 |
| RF008 | Adicionar redes sociais | P1 | F01 | AC001 |
| RF009 | Selecionar redes para compartilhar | P1 | F01 | AC001 |
| RF010 | Adicionar endereço | P1 | F01 | AC001 |
| RF011 | Adicionar observações | P2 | F01 | AC001 |
| RF012 | Visualizar cartão completo | P0 | F01 | AC001 |

---

## 2. NFC

| ID | Requisito | Prioridade | Feature | Critério |
|----|-----------|------------|---------|----------|
| RF020 | Enviar cartão via NFC | P0 | F02 | AC002 |
| RF021 | Receber cartão via NFC | P0 | F02 | AC002 |
| RF022 | Confirmar envio antes de transmitir | P0 | F02 | AC002 |
| RF023 | Confirmar recebimento antes de importar | P0 | F02 | AC002 |
| RF024 | Cancelar transmissão em andamento | P0 | F02 | AC002 |
| RF025 | Exibir progresso de transmissão | P0 | F02 | AC002 |
| RF026 | Detectar disponibilidade de NFC | P0 | F02 | AC002 |
| RF027 | Informar quando NFC indisponível | P0 | F02 | AC002 |
| RF028 | Funcionar 100% offline | P0 | F02 | AC002 |
| RF029 | Transmitir em menos de 5 segundos | P0 | F02 | AC010 |

---

## 3. QR Code

| ID | Requisito | Prioridade | Feature | Critério |
|----|-----------|------------|---------|----------|
| RF030 | Gerar QR Code localmente | P0 | F03 | AC003 |
| RF031 | QR contendo vCard completa | P0 | F03 | AC003 |
| RF032 | Ler QR Code via câmera | P0 | F04 | AC003 |
| RF033 | Decodificar em menos de 3 segundos | P0 | F04 | AC010 |
| RF034 | Exibir dados antes de importar | P0 | F04 | AC003 |
| RF035 | Solicitar confirmação antes de importar | P0 | F04 | AC003 |
| RF036 | Compatível Android ↔ iOS | P0 | F03/F04 | AC003 |

---

## 4. vCard

| ID | Requisito | Prioridade | Feature | Critério |
|----|-----------|------------|---------|----------|
| RF040 | Gerar vCard RFC 6350 | P0 | F05 | AC004 |
| RF041 | Incluir apenas dados autorizados | P0 | F05 | AC004 |
| RF042 | Validar campos obrigatórios | P0 | F05 | AC004 |
| RF043 | Compatível com Android | P0 | F05 | AC004 |
| RF044 | Compatível com iOS | P0 | F05 | AC004 |
| RF045 | Compatível com Outlook | P0 | F05 | AC004 |
| RF046 | Compatível com Apple Contacts | P0 | F05 | AC004 |
| RF047 | Compatível com Google Contacts | P0 | F05 | AC004 |
| RF048 | Importar vCard recebido | P0 | F06 | AC004 |
| RF049 | Validar formato vCard recebido | P0 | F06 | AC004 |

---

## 5. Biometria

| ID | Requisito | Prioridade | Feature | Critério |
|----|-----------|------------|---------|----------|
| RF050 | Detectar biometria disponível | P0 | F07 | AC005 |
| RF051 | Utilizar Face ID quando disponível | P0 | F07 | AC005 |
| RF052 | Utilizar impressão digital quando disponível | P0 | F07 | AC005 |
| RF053 | Solicitar PIN como fallback | P0 | F07 | AC005 |
| RF054 | Nunca armazenar dados biométricos | P0 | F07 | AC005 |
| RF055 | Utilizar APIs oficiais | P0 | F07 | AC005 |
| RF056 | Criar PIN (4-6 dígitos) | P0 | F07 | AC005 |
| RF057 | Validar PIN corretamente | P0 | F07 | AC005 |
| RF058 | Bloquear após tentativas falhas | P1 | F07 | AC005 |

---

## 6. Temas

| ID | Requisito | Prioridade | Feature | Critério |
|----|-----------|------------|---------|----------|
| RF060 | Tema claro | P1 | F08 | AC008 |
| RF061 | Tema escuro | P1 | F08 | AC008 |
| RF062 | Tema do sistema | P1 | F08 | AC008 |
| RF063 | Alteração sem reiniciar app | P1 | F08 | AC008 |
| RF064 | Manter preferência entre sessões | P1 | F08 | AC008 |

---

## 7. Internacionalização

| ID | Requisito | Prioridade | Feature | Critério |
|----|-----------|------------|---------|----------|
| RF070 | Suporte a Português | P1 | F09 | AC007 |
| RF071 | Suporte a Inglês | P1 | F09 | AC007 |
| RF072 | Suporte a Espanhol | P1 | F09 | AC007 |
| RF073 | Suporte a Francês | P1 | F09 | AC007 |
| RF074 | Suporte a Italiano | P1 | F09 | AC007 |
| RF075 | Suporte a Alemão | P1 | F09 | AC007 |
| RF076 | Suporte a Japonês | P1 | F09 | AC007 |
| RF077 | Suporte a Chinês | P1 | F09 | AC007 |
| RF078 | Utilizar ARB para todas as strings | P1 | F09 | AC007 |
| RF079 | Troca dinâmica de idioma | P1 | F09 | AC007 |
| RF080 | Seguir idioma do sistema | P1 | F09 | AC007 |

---

## 8. WhatsApp

| ID | Requisito | Prioridade | Feature | Critério |
|----|-----------|------------|---------|----------|
| RF090 | Compartilhar via WhatsApp | P1 | F10 | - |
| RF091 | Abrir WhatsApp diretamente | P1 | F10 | - |
| RF092 | Enviar dados formatados | P1 | F10 | - |

---

## 9. Anúncios

| ID | Requisito | Prioridade | Feature | Critério |
|----|-----------|------------|---------|----------|
| RF100 | Integrar Google Mobile Ads | P1 | F11 | AC006 |
| RF101 | Nunca mostrar durante cadastro | P1 | F11 | AC006 |
| RF102 | Nunca mostrar durante compartilhamento | P1 | F11 | AC006 |
| RF103 | Nunca mostrar durante leitura QR | P1 | F11 | AC006 |
| RF104 | Nunca mostrar durante NFC | P1 | F11 | AC006 |
| RF105 | Nunca mostrar durante biometria | P1 | F11 | AC006 |
| RF106 | Nunca mostrar durante configurações | P1 | F11 | AC006 |

---

## 10. Atualização da Agenda

| ID | Requisito | Prioridade | Feature | Critério |
|----|-----------|------------|---------|----------|
| RF110 | Atualizar contatos existentes | P2 | F12 | - |
| RF111 | Detectar duplicatas | P2 | F12 | - |
| RF112 | Solicitar confirmação antes de atualizar | P2 | F12 | - |
| RF113 | Não sobrescrever sem autorização | P2 | F12 | - |

---

## 11. Armazenamento

| ID | Requisito | Prioridade | Feature | Critério |
|----|-----------|------------|---------|----------|
| RF120 | Armazenar perfil no Hive | P0 | - | AC001 |
| RF121 | Armazenar configurações no Hive | P0 | - | - |
| RF122 | Armazenar cartões recebidos no Hive | P0 | - | AC004 |
| RF123 | Limpar dados ao desinstalar | P0 | - | BR023 |

---

## 12. Permissões

| ID | Requisito | Prioridade | Feature | Critério |
|----|-----------|------------|---------|----------|
| RF130 | Solicitar permissão NFC | P0 | F02 | - |
| RF131 | Solicitar permissão câmera | P0 | F04 | - |
| RF132 | Solicitar permissão contatos | P1 | F12 | - |
| RF133 | Solicitar permissão biometria | P0 | F07 | - |
| RF134 | Tratar permissão negada | P0 | - | - |
| RF135 | Não acessar dados sem permissão | P0 | - | - |

---

## Documentos Relacionados

- [05_Features.md](./05_Features.md)
- [08_BusinessRules.md](./08_BusinessRules.md)
- [10_NonFunctionalRequirements.md](./10_NonFunctionalRequirements.md)
- [11_AcceptanceCriteria.md](./11_AcceptanceCriteria.md)
