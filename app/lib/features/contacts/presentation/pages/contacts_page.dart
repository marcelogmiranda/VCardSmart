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

    ref.listen<ContactListStatus>(contactListProvider, (previous, next) {
      if (previous != null &&
          previous.status == ContactStatus.loading &&
          next.status == ContactStatus.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Contato importado com sucesso!'),
          ),
        );
      }
    });

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
    final theme = Theme.of(context);
    Future<void> onRefresh() =>
        ref.read(contactListProvider.notifier).loadContacts();

    if (status.status == ContactStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (status.status == ContactStatus.error) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Não foi possível carregar os contatos'),
              if (status.error != null) ...[
                const SizedBox(height: 8),
                Text(
                  status.error!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.read(contactListProvider.notifier).loadContacts(),
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      );
    }

    if (status.contacts.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 64,
                        color: theme.colorScheme.outline,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Nenhum contato importado',
                        style: TextStyle(
                          fontSize: 18,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Use QR Code, NFC ou vCard para importar',
                        style: TextStyle(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      FilledButton.icon(
                        onPressed: () => _showImportDialog(context, ref),
                        icon: const Icon(Icons.add),
                        label: const Text('Importar contato'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    final sorted = [...status.contacts]
      ..sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: sorted.length,
        addAutomaticKeepAlives: false,
        addRepaintBoundaries: true,
        itemBuilder: (context, index) {
          final contact = sorted[index];
          return Dismissible(
            key: ValueKey('contact-${contact.id}'),
            direction: DismissDirection.endToStart,
            background: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                Icons.delete,
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
            confirmDismiss: (_) => _confirmDelete(context, contact.name),
            onDismissed: (_) {
              ref.read(contactListProvider.notifier).deleteContact(contact.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${contact.name} excluído')),
              );
            },
            child: ContactCard(
              contact: contact,
              onTap: () => _showContactDetails(context, contact),
            ),
          );
        },
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context, String name) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir contato?'),
        content: Text('Deseja excluir "$name" da sua lista?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
    return result ?? false;
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
              _DetailRow(
                icon: Icons.camera_alt_outlined,
                text: contact.instagram!,
              ),
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
          Icon(
            icon,
            size: 18,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
