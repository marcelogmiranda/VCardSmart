import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/contact_provider.dart';
import '../widgets/contact_card.dart';
import '../widgets/import_dialog.dart';
import '../../domain/entities/contact.dart';
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
            const Text('Não foi possível carregar os contatos'),
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
          onTap: () => _showContactDetails(context, contact),
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

  void _showContactDetails(BuildContext context, Contact contact) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(contact.name),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (contact.email != null && contact.email!.isNotEmpty)
              _DetailRow(icon: Icons.email_outlined, text: contact.email!),
            if (contact.phone != null && contact.phone!.isNotEmpty)
              _DetailRow(icon: Icons.phone_outlined, text: contact.phone!),
            if (contact.website != null && contact.website!.isNotEmpty)
              _DetailRow(icon: Icons.language, text: contact.website!),
            if (contact.linkedin != null && contact.linkedin!.isNotEmpty)
              _DetailRow(icon: Icons.work_outline, text: contact.linkedin!),
            if (contact.instagram != null && contact.instagram!.isNotEmpty)
              _DetailRow(icon: Icons.camera_alt_outlined, text: contact.instagram!),
            if (contact.bio != null && contact.bio!.isNotEmpty)
              _DetailRow(icon: Icons.notes, text: contact.bio!),
            if (contact.email == null &&
                contact.phone == null &&
                contact.website == null &&
                contact.linkedin == null &&
                contact.instagram == null &&
                contact.bio == null)
              Text(
                'Nenhum dado adicional',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _DetailRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
