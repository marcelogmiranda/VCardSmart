# Diagramas Mermaid — VCardSmart

## Clean Architecture

```mermaid
graph TB
    subgraph Presentation
        A[Pages] --> B[Widgets]
        B --> C[Providers]
    end
    
    subgraph Domain
        D[Entities] --> E[UseCases]
        E --> F[Repository Interface]
    end
    
    subgraph Data
        G[Models] --> H[Datasources]
        H --> I[Repository Implementation]
    end
    
    C --> E
    F --> I
```

## Feature Structure

```mermaid
graph TB
    subgraph Feature
        subgraph Data
            D1[Datasources]
            D2[Models]
            D3[Repository Impl]
        end
        
        subgraph Domain
            DO1[Entities]
            DO2[UseCases]
            DO3[Repository Interface]
        end
        
        subgraph Presentation
            P1[Pages]
            P2[Widgets]
            P3[Providers]
        end
    end
    
    D1 --> D3
    D2 --> D3
    D3 --> DO3
    DO1 --> DO2
    DO2 --> DO3
    P3 --> DO2
```

## Data Flow

```mermaid
sequenceDiagram
    participant U as User
    participant P as Provider
    participant UC as UseCase
    participant R as Repository
    participant DS as DataSource
    
    U->>P: Action
    P->>UC: Execute
    UC->>R: Get Data
    R->>DS: Query
    DS-->>R: Result
    R-->>UC: Entity
    UC-->>P: Result
    P-->>U: UI Update
```

## Navigation

```mermaid
graph TB
    subgraph GoRouter
        A[/] --> B[/home]
        A --> C[/profile]
        A --> D[/settings]
        A --> E[/history]
        C --> F[/profile/:id]
        C --> G[/profile/create]
        C --> H[/profile/edit/:id]
        A --> I[/import]
        A --> J[/share]
    end
```

## Security Flow

```mermaid
sequenceDiagram
    participant U as User
    participant A as Auth
    participant S as SecureStorage
    participant E as Encryption
    participant D as Data
    
    U->>A: Authenticate
    A->>S: Verify
    S-->>A: Token
    A-->>U: Success
    U->>E: Get Data
    E->>S: Get Key
    S-->>E: Key
    E->>D: Decrypt
    D-->>E: Data
    E-->>U: Decrypted Data
```

## QR Code Flow

```mermaid
sequenceDiagram
    participant S as Sender
    participant QR as QR Code
    participant R as Receiver
    
    S->>QR: Generate
    QR-->>R: Scan
    R->>R: Decode
    R->>R: Validate
    R-->>R: Import
```

## NFC Flow

```mermaid
sequenceDiagram
    participant S as Sender
    participant N as NFC
    participant R as Receiver
    
    S->>N: Send Data
    N-->>R: Receive
    R->>R: Decode
    R->>R: Validate
    R-->>R: Import
```

## State Management

```mermaid
graph TB
    subgraph Riverpod
        A[Provider] --> B[StateNotifier]
        B --> C[State]
        C --> D[UI]
        D --> E[User Action]
        E --> B
    end
```

## Testing Strategy

```mermaid
graph TB
    subgraph Tests
        A[Unit Tests] --> B[Domain]
        A --> C[Data]
        D[Widget Tests] --> E[Presentation]
        F[Integration Tests] --> G[Complete Flow]
        H[Golden Tests] --> I[Visual]
    end
```

## Deployment Pipeline

```mermaid
graph LR
    A[Code] --> B[Build]
    B --> C[Test]
    C --> D[Analyze]
    D --> E[Release]
    E --> F[Store]
```

## Monetization Flow

```mermaid
graph TB
    subgraph Free
        A[Banner Ads]
        B[Interstitial Ads]
    end
    
    subgraph Premium
        C[No Ads]
        D[Multiple Cards]
        E[Templates]
        F[Backup]
    end
    
    G[User] --> H{Choice}
    H -->|Free| A
    H -->|Free| B
    H -->|Premium| C
    H -->|Premium| D
    H -->|Premium| E
    H -->|Premium| F
```
