# Business Rules

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Legenda

| Símbolo | Significado |
|---------|-------------|
| ✅ | Permitido |
| ❌ | Proibido |
| ⚠️ | Condicional |

---

## Regras de Cartão

### BR001 – Cartão Único
Existe apenas um cartão ativo por usuário.
- ✅ Criar um novo cartão (substitui o anterior)
- ✅ Editar cartão existente
- ❌ Ter múltiplos cartões simultâneos (V1)

### BR002 – E-mail Único
Existe apenas um e-mail por cartão.
- ✅ Informar um e-mail
- ❌ Informar múltiplos e-mails

### BR003 – Múltiplos Telefones
Pode existir vários telefones por cartão.
- ✅ Informar 0 a N telefones
- ✅ Definir telefone principal

### BR004 – Múltiplas Redes Sociais
Pode existir várias redes sociais por cartão.
- ✅ Informar 0 a N redes sociais
- ✅ Selecionar quais compartilhar

### BR005 – Compartilhamento Seletivo
Somente compartilhar redes cadastradas.
- ✅ Compartilhar rede cadastrada e habilitada
- ❌ Compartilhar rede não cadastrada
- ❌ Compartilhar rede desabilitada

---

## Regras de Compartilhamento

### BR006 – Confirmação Obrigatória
Todo compartilhamento exige confirmação do usuário.
- ✅ Compartilhar após confirmação explícita
- ❌ Compartilhar automaticamente
- ❌ Compartilhar em segundo plano

### BR007 – Confirmação de Importação
Toda importação exige confirmação do receptor.
- ✅ Importar após confirmação explícita
- ❌ Importar automaticamente
- ❌ Sobrescrever dados existentes sem confirmação

### BR008 – Dados Compartilhados
Somente dados autorizados pelo usuário são compartilhados.
- ✅ Dados selecionados no momento do compartilhamento
- ❌ Todos os dados automaticamente

---

## Regras de Privacidade

### BR009 – Zero Servidor
Nenhuma informação é enviada para servidores.
- ❌ Enviar dados para backend
- ❌ Enviar dados para analytics
- ❌ Enviar dados para serviços terceiros

### BR010 – Armazenamento Local
Todo armazenamento é Hive.
- ✅ Hive como único banco de dados
- ❌ SQLite
- ❌ Firebase
- ❌ SharedPreferences para dados sensíveis

### BR011 – Sem Rastreamento
Nenhum dado de uso é coletado.
- ❌ Analytics
- ❌ Crashlytics
- ❌ Métricas de uso

### BR012 – Sem Login
Nenhuma autenticação de servidor é necessária.
- ❌ Login por e-mail
- ❌ Login por redes sociais
- ❌ Conta de usuário

---

## Regras de Dados

### BR013 – Campos Obrigatórios
Os seguintes campos são obrigatórios:
- Nome completo
- E-mail
- Pelo menos um telefone

### BR014 – Campos Opcionais
Os seguintes campos são opcionais:
- Foto
- Logotipo
- Empresa
- Cargo
- Site
- Redes sociais
- Endereço
- Observações

### BR015 – Validação de E-mail
O e-mail deve seguir o formato válido.
- ✅ usuario@dominio.com
- ❌ usuario@dominio
- ❌ usuario.com

### BR016 – Validação de Telefone
O telefone deve conter apenas números, espaços, parênteses, hífens e o símbolo +.
- ✅ +55 11 99999-9999
- ✅ (11) 99999-9999
- ❌ abc123

---

## Regras de Segurança

### BR017 – Biometria Opcional
Biometria é opcional mas recomendada.
- ✅ Ativar biometria
- ✅ Desativar biometria
- ✅ Usar PIN como fallback

### BR018 – PIN
O PIN deve ter 4 a 6 dígitos.
- ✅ 1234
- ✅ 123456
- ❌ 123
- ❌ abc

### BR019 – Dados Biométricos
Nunca armazenar dados biométricos.
- ❌ Armazenar impressão digital
- ❌ Armazenar Face ID
- ✅ Utilizar APIs do sistema

---

## Regras de Compatibilidade

### BR020 – Android Mínimo
Suporte a Android 6.0 (API 23) ou superior.

### BR021 – iOS Mínimo
Suporte a iOS 13.0 ou superior.

### BR022 – NFC
Funcionalidade degrada gracefulmente quando NFC indisponível.
- ✅ Funcionar sem NFC
- ✅ Informar limitação
- ✅ Oferecer alternativas (QR Code)

---

## Regras de Desinstalação

### BR023 – Limpeza Total
Ao desinstalar, todo conteúdo desaparece.
- ✅ Todos os dados são removidos
- ❌ Nenhum dado permanece no dispositivo
- ❌ Nenhum dado é enviado para backup

---

## Documentos Relacionados

- [05_Features.md](./05_Features.md)
- [09_FunctionalRequirements.md](./09_FunctionalRequirements.md)
- [11_AcceptanceCriteria.md](./11_AcceptanceCriteria.md)
- [13_Privacy.md](./13_Privacy.md)
