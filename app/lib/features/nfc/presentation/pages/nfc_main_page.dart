import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/nfc_provider.dart';
import '../../../../core/constants/app_constants.dart';

class NFCMainPage extends ConsumerStatefulWidget {
  const NFCMainPage({super.key});

  @override
  ConsumerState<NFCMainPage> createState() => _NFCMainPageState();
}

class _NFCMainPageState extends ConsumerState<NFCMainPage> {
  bool? _nfcAvailable;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkNFC();
    });
  }

  Future<void> _checkNFC() async {
    await ref.read(nfcProvider.notifier).checkAvailability();
    if (!mounted) return;
    setState(() => _nfcAvailable = ref.read(nfcProvider).isAvailable);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_nfcAvailable == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('NFC'),
          centerTitle: true,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_nfcAvailable == false) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('NFC'),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.contactless,
                  size: 80,
                  color: theme.colorScheme.error,
                ),
                const SizedBox(height: 24),
                Text(
                  'NFC não disponível',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Este dispositivo não possui funcionalidade NFC ou está desativado.\n\n'
                  'Para usar esta funcionalidade, ative o NFC nas configurações do dispositivo ou '
                  'utilize um aparelho com suporte a NFC.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.go(AppConstants.homeRoute),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Voltar ao Início'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('NFC'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.contactless,
                size: 80,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Compartilhar e Receber via NFC',
                style: theme.textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                'Utilize o NFC para compartilhar ou receber contatos '
                'aproximando o dispositivo de um cartão NFC.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => context.push(AppConstants.nfcShareRoute),
                  icon: const Icon(Icons.upload),
                  label: const Text('Gravar Cartão'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => context.push(AppConstants.nfcReceiveRoute),
                  icon: const Icon(Icons.download),
                  label: const Text('Receber Contato'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
