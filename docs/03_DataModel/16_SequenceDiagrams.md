# Sequence Diagrams

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0 |
| **Projeto** | VCardSmart |
| **Última atualização** | 2026-07-13 |

---

## Editar Perfil

```mermaid
sequenceDiagram
    actor U as Usuário
    participant P as Page
    participant C as Controller
    participant UC as UseCase
    participant R as Repository
    participant D as DataSource
    participant H as Hive

    U->>P: Acessa editar perfil
    P->>C: Carregar perfil
    C->>UC: GetProfile()
    UC->>R: getProfile()
    R->>D: getProfile()
    D->>H: box.get('profile')
    H-->>D: UserProfileModel
    D-->>R: UserProfile
    R-->>UC: UserProfile
    UC-->>C: UserProfile
    C-->>P: ProfileLoaded
    P-->>U: Exibir formulário

    U->>P: Modificar dados
    U->>P: Confirmar
    P->>C: Salvar perfil
    C->>UC: SaveProfile(profile)
    UC->>R: saveProfile(profile)
    R->>D: saveProfile(profile)
    D->>H: box.put('profile', model)
    H-->>D: Sucesso
    D-->>R: Sucesso
    R-->>UC: Sucesso
    UC-->>C: Sucesso
    C-->>P: ProfileSaved
    P-->>U: Confirmação
```

---

## Compartilhar NFC

```mermaid
sequenceDiagram
    actor U as Usuário
    participant P as Page
    participant C as Controller
    participant NFC as NfcService
    participant V as VCardGenerator

    U->>P: Selecionar NFC
    P->>C: Iniciar compartilhamento
    C->>V: Gerar vCard(perfil)
    V-->>C: vCard
    C->>V: Gerar JSON(perfil)
    V-->>C: JSON
    C-->>P: Payload pronto
    P-->>U: Exibir dados + confirmar

    U->>P: Confirmar envio
    P->>C: Enviar
    C->>NFC: Transmitir(payload)
    NFC-->>C: Sucesso
    C-->>P: Enviado
    P-->>U: Confirmação
```

---

## Receber NFC

```mermaid
sequenceDiagram
    actor R as Receptor
    participant NFC as NfcService
    participant C as Controller
    participant P as Page
    participant V as VCardValidator
    participant Repo as Repository
    participant H as Hive

    NFC->>NFC: Detectar transmissão
    NFC->>C: Dados recebidos
    C->>V: Validar dados
    V-->>C: Válido
    C->>P: Exibir dados
    P-->>R: Mostrar cartão

    R->>P: Confirmar importação
    P->>C: Importar
    C->>Repo: Salvar receivedCard
    Repo->>H: box.put()
    H-->>Repo: Sucesso
    Repo-->>C: Sucesso
    C-->>P: Importado
    P-->>R: Confirmação
```

---

## Gerar QR Code

```mermaid
sequenceDiagram
    actor U as Usuário
    participant P as Page
    participant C as Controller
    participant QR as QrGenerator
    participant V as VCardGenerator

    U->>P: Selecionar QR Code
    P->>C: Gerar QR
    C->>V: Gerar vCard(perfil)
    V-->>C: vCard
    C->>QR: GerarQR(vCard)
    QR-->>C: QR Image
    C-->>P: QR Code pronto
    P-->>U: Exibir QR Code
```

---

## Ler QR Code

```mermaid
sequenceDiagram
    actor R as Receptor
    participant P as Page
    participant C as Controller
    participant Cam as Camera
    participant V as VCardValidator
    participant Repo as Repository
    participant H as Hive

    R->>P: Iniciar leitura
    P->>Cam: Ativar câmera
    Cam->>Cam: Detectar QR Code
    Cam->>C: Payload decodificado
    C->>V: Validar dados
    V-->>C: Válido
    C->>P: Exibir dados
    P-->>R: Mostrar cartão

    R->>P: Confirmar importação
    P->>C: Importar
    C->>Repo: Salvar receivedCard
    Repo->>H: box.put()
    H-->>Repo: Sucesso
    Repo-->>C: Sucesso
    C-->>P: Importado
    P-->>R: Confirmação
```

---

## Documentos Relacionados

- [16_SequenceDiagrams.md](./16_SequenceDiagrams.md)
- [17_ERDiagram.md](./17_ERDiagram.md)
- [18_ClassDiagram.md](./18_ClassDiagram.md)
