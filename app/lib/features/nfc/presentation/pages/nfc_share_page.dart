import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/nfc_provider.dart';
import '../widgets/nfc_status_widget.dart';
import '../widgets/nfc_instruction_widget.dart';
import '../../../profile/domain/entities/profile.dart';
import '../../../profile/presentation/providers/profile_provider.dart';

class NFCShareRoutePage extends ConsumerStatefulWidget {
  const NFCShareRoutePage({super.key});

  @override
  ConsumerState<NFCShareRoutePage> createState() => _NFCShareRoutePageState();
}

class _NFCShareRoutePageState extends ConsumerState<NFCShareRoutePage> {
  bool? _nfcAvailable;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkNFC();
      ref.read(profileListProvider.notifier).loadProfiles();
    });
  }

  Future<void> _checkNFC() async {
    await ref.read(nfcProvider.notifier).checkAvailability();
    if (!mounted) return;
    setState(() => _nfcAvailable = ref.read(nfcProvider).isAvailable);
  }

  @override
  Widget build(BuildContext context) {
    if (_nfcAvailable == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Compartilhar via NFC')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_nfcAvailable == false) {
      final theme = Theme.of(context);
      return Scaffold(
        appBar: AppBar(title: const Text('Compartilhar via NFC')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.nfc, size: 80, color: theme.colorScheme.error),
                const SizedBox(height: 24),
                Text(
                  'NFC não disponível',
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Este dispositivo não possui NFC ou está desativado.\nAtive o NFC nas configurações do dispositivo.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                OutlinedButton.icon(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Voltar'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Consumer(
      builder: (context, ref, child) {
        final profiles = ref.watch(profileListProvider);
        return profiles.when(
          data: (list) => list.isEmpty
              ? _NoProfile()
              : NFCSharePage(profile: list.first),
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
          error: (e, st) => _NoProfile(),
        );
      },
    );
  }
}

class _NoProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compartilhar via NFC')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Nenhum perfil encontrado',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Crie seu perfil para compartilhar via NFC',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class NFCSharePage extends ConsumerWidget {
  final Profile profile;

  const NFCSharePage({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nfcStatus = ref.watch(nfcProvider);

    ref.listen<NFCStatus>(nfcProvider, (previous, next) {
      if (next.state == NFCState.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Perfil enviado com sucesso!')),
        );
      } else if (next.state == NFCState.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Não foi possível enviar via NFC'),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compartilhar via NFC'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NFCStatusWidget(isAvailable: nfcStatus.isAvailable),
            const SizedBox(height: 32),
            NFCInstructionWidget(state: nfcStatus.state),
            const SizedBox(height: 32),
            if (nfcStatus.state == NFCState.idle)
              ElevatedButton(
                onPressed: () {
                  ref.read(nfcProvider.notifier).send(profile);
                },
                child: const Text('Iniciar envio'),
              ),
            if (nfcStatus.state == NFCState.success)
              ElevatedButton(
                onPressed: () {
                  ref.read(nfcProvider.notifier).reset();
                },
                child: const Text('Enviar novamente'),
              ),
          ],
        ),
      ),
    );
  }
}
