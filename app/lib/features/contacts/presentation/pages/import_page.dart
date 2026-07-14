import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/contact_provider.dart';
import '../widgets/import_dialog.dart';
import '../../domain/usecases/import_contact_usecase.dart';

class ImportPage extends ConsumerWidget {
  const ImportPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Importar Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Icon(
                      Icons.import_contacts,
                      size: 64,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Importe contatos de diversas fontes',
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _importViaQR(context, ref),
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Importar via QR Code'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () => _importViaNFC(context, ref),
              icon: const Icon(Icons.nfc),
              label: const Text('Importar via NFC'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () => _importViaVCard(context, ref),
              icon: const Icon(Icons.description),
              label: const Text('Importar via vCard'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _importViaQR(BuildContext context, WidgetRef ref) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Abrir leitor QR Code...')),
    );
  }

  void _importViaNFC(BuildContext context, WidgetRef ref) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Abrir leitor NFC...')),
    );
  }

  void _importViaVCard(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => ImportDialog(
        onImport: (data, source) {
          final importSource = ImportSource.values.firstWhere(
            (e) => e.name == source,
            orElse: () => ImportSource.vcard,
          );
          ref.read(contactListProvider.notifier).importData(data, importSource);
        },
      ),
    );
  }
}
