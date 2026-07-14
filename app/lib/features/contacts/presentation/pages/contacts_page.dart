import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/contact_provider.dart';
import '../widgets/contact_card.dart';
import '../widgets/import_dialog.dart';
import '../../domain/usecases/import_contact_usecase.dart';

class ContactsPage extends ConsumerWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(contactListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => _showImportDialog(context, ref),
          ),
        ],
      ),
      body: _buildBody(context, ref, status),
    );
  }

  Widget _buildBody(
    BuildContext context,
    WidgetRef ref,
    ContactListStatus status,
  ) {
    if (status.status == ContactStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (status.status == ContactStatus.error) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Erro: ${status.error}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => ref.read(contactListProvider.notifier).loadContacts(),
              child: const Text('Tentar novamente'),
            ),
          ],
        ),
      );
    }

    if (status.contacts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_outline, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Nenhum contato importado',
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(
              'Use QR Code, NFC ou vCard para importar',
              style: TextStyle(color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: status.contacts.length,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: true,
      itemBuilder: (context, index) {
        final contact = status.contacts[index];
        return ContactCard(
          contact: contact,
          onTap: () {},
        );
      },
    );
  }

  void _showImportDialog(BuildContext context, WidgetRef ref) {
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
