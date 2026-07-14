# Troubleshooting — VCardSmart

## Problemas Conhecidos

### Build

#### Erro: Unable to find a suitable Flutter SDK

**Solução**:
```bash
flutter clean
flutter pub get
```

#### Erro: Dependency version conflict

**Solução**:
```bash
flutter pub outdated
flutter pub upgrade
```

#### Erro: CocoaPods not installed

**Solução**:
```bash
sudo gem install cocoapods
cd ios && pod install
```

### NFC

#### NFC não funciona no Android

**Causas**:
- NFC desativado no dispositivo
- Dispositivo não suporta NFC
- Permissão não concedida

**Solução**:
1. Verifique se NFC está ativado
2. Verifique se o dispositivo suporta NFC
3. Conceda permissão de NFC

#### NFC não funciona no iOS

**Causas**:
- NFC desativado no dispositivo
- Dispositivo não suporta NFC
- Permissão não concedida

**Solução**:
1. Verifique se NFC está ativado em Ajustes > NFC
2. Verifique se o dispositivo suporta NFC (iPhone 7 ou superior)

### QR Code

#### Câmera não abre

**Causas**:
- Permissão não concedida
- Câmera em uso por outro app
- Dispositivo sem câmera

**Solução**:
1. Conceda permissão de câmera
2. Feche outros apps que usam câmera
3. Verifique se o dispositivo tem câmera

#### QR Code não é escaneado

**Causas**:
- QR Code ilegível
- Iluminação inadequada
- Distância incorreta

**Solução**:
1. Melhore a iluminação
2. Aproxime o dispositivo
3. Mantenha o QR Code estável

### Biometria

#### Biometria não funciona

**Causas**:
- Biometria não configurada no dispositivo
- Biometria bloqueada após tentativas
- Dispositivo sem sensor

**Solução**:
1. Configure biometria nas configurações do dispositivo
2. Desbloqueie o dispositivo
3. Use PIN como alternativa

### Dados

#### Dados corrompidos

**Solução**:
1. Limpe os dados do app
2. Recrie o perfil
3. Se necessário, desinstale e reinstale

#### App trava ao abrir

**Solução**:
1. Force feche o app
2. Limpe o cache
3. Se necessário, limpe os dados

### Performance

#### App lento

**Causas**:
- Muitos contatos importados
- Dispositivo antigo
- Memória insuficiente

**Solução**:
1. Exclua contatos não utilizados
2. Reinicie o dispositivo
3. Libere memória

#### Consumo alto de bateria

**Causas**:
- NFC ativo constantemente
- Câmera ativa
- Localização ativa

**Solução**:
1. Desative NFC quando não necessário
2. Feche o app quando não estiver usando
3. Verifique permissões

### Compartilhamento

#### QR Code não é compartilhado

**Solução**:
1. Verifique se a permissão de armazenamento foi concedida
2. Tente salvar na galeria
3. Use a função de compartilhar

#### vCard não é importada

**Solução**:
1. Verifique o formato do arquivo
2. Tente importar novamente
3. Verifique se o contato já existe

## Contato

### Suporte

- Email: suporte@vcardsmart.app
- Formulário: vcardsmart.app/support
- FAQ: vcardsmart.app/faq

### Reportar Bug

- Email: bugs@vcardsmart.app
- GitHub: github.com/vcardsmart/app/issues
