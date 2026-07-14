# UML — VCardSmart

## Class Diagram

### Profile

```mermaid
classDiagram
    class Profile {
        -String id
        -String name
        -String? email
        -String? phone
        -String? linkedin
        -String? website
        -String? bio
        -DateTime createdAt
        -DateTime updatedAt
        +Profile(id, name, email?, phone?, linkedin?, website?, bio?, createdAt, updatedAt)
    }
    
    class SocialLink {
        -String platform
        -String url
        -String? username
        +SocialLink(platform, url, username?)
    }
    
    Profile "1" *-- "*" SocialLink
```

### Repository

```mermaid
classDiagram
    class ProfileRepository {
        <<interface>>
        +getProfile(String id) Future~Profile~
        +getAllProfiles() Future~List~Profile~~
        +saveProfile(Profile profile) Future~void~
        +deleteProfile(String id) Future~void~
    }
    
    class LocalProfileRepository {
        -ProfileDataSource dataSource
        +getProfile(String id) Future~Profile~
        +getAllProfiles() Future~List~Profile~~
        +saveProfile(Profile profile) Future~void~
        +deleteProfile(String id) Future~void~
    }
    
    ProfileRepository <|.. LocalProfileRepository
```

### UseCase

```mermaid
classDiagram
    class GetProfileUseCase {
        -ProfileRepository repository
        +GetProfileUseCase(repository)
        +call(String id) Future~Profile~
    }
    
    class CreateProfileUseCase {
        -ProfileRepository repository
        +CreateProfileUseCase(repository)
        +call(Profile profile) Future~void~
    }
    
    GetProfileUseCase --> ProfileRepository
    CreateProfileUseCase --> ProfileRepository
```

## Sequence Diagram

### Profile Creation

```mermaid
sequenceDiagram
    participant U as User
    participant P as ProfilePage
    participant N as ProfileNotifier
    participant UC as CreateProfileUseCase
    participant R as ProfileRepository
    participant DS as HiveDataSource
    
    U->>P: Fill form
    P->>N: createProfile()
    N->>UC: call(profile)
    UC->>R: saveProfile(profile)
    R->>DS: put(profile)
    DS-->>R: success
    R-->>UC: void
    UC-->>N: void
    N-->>P: state = success
    P-->>U: Navigate to profile
```

### QR Code Share

```mermaid
sequenceDiagram
    participant U as User
    participant P as SharePage
    participant QR as QRService
    participant S as SharePlus
    
    U->>P: Tap share
    P->>QR: generate(profile)
    QR-->>P: QR Image
    P-->>U: Show QR
    U->>P: Tap save
    P->>S: shareFile(qrImage)
    S-->>P: success
    P-->>U: Shared
```

## Activity Diagram

### Profile Flow

```mermaid
flowchart TD
    A[Start] --> B[Open App]
    B --> C{Profile exists?}
    C -->|No| D[Create Profile]
    C -->|Yes| E[Show Profile]
    D --> F[Fill Form]
    F --> G[Save Profile]
    G --> E
    E --> H[Edit Profile]
    E --> I[Share Profile]
    E --> J[Import Contact]
    H --> K[Save Changes]
    K --> E
```

### Import Flow

```mermaid
flowchart TD
    A[Start] --> B[Choose Import Method]
    B --> C[QR Code]
    B --> D[NFC]
    B --> E[vCard File]
    C --> F[Scan QR]
    D --> G[Receive NFC]
    E --> H[Select File]
    F --> I[Decode Data]
    G --> I
    H --> I
    I --> J[Validate Data]
    J --> K{Valid?}
    K -->|No| L[Show Error]
    K -->|Yes| M[Import Contact]
    M --> N[Success]
    L --> B
```

## State Diagram

### Profile State

```mermaid
stateDiagram-v2
    [*] --> Idle
    Idle --> Loading : loadProfile
    Loading --> Loaded : success
    Loading --> Error : failure
    Loaded --> Editing : edit
    Editing --> Saving : save
    Saving --> Loaded : success
    Saving --> Error : failure
    Error --> Loading : retry
    Loaded --> [*]
```

## Component Diagram

### App Structure

```mermaid
graph TB
    subgraph App
        subgraph Core
            A[Constants]
            B[Theme]
            C[Router]
            D[Utils]
            E[Errors]
        end
        
        subgraph Features
            F[Profile]
            G[QR Code]
            H[NFC]
            I[Import]
            J[Settings]
        end
        
        subgraph Shared
            K[Widgets]
            L[Providers]
        end
    end
    
    F --> Core
    G --> Core
    H --> Core
    I --> Core
    J --> Core
    F --> Shared
    G --> Shared
    H --> Shared
    I --> Shared
    J --> Shared
```

## Package Diagram

```mermaid
graph TB
    subgraph Packages
        A[flutter_app]
        B[core]
        C[features]
        D[data]
        E[domain]
        F[presentation]
        G[l10n]
    end
    
    A --> B
    A --> C
    A --> G
    C --> D
    C --> E
    C --> F
    D --> E
    F --> E
```
