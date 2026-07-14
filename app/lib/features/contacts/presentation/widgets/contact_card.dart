import 'package:flutter/material.dart';
import '../../domain/entities/contact.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;
  final VoidCallback? onTap;

  const ContactCard({
    super.key,
    required this.contact,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '?',
          ),
        ),
        title: Text(contact.name),
        subtitle: Text(contact.email ?? contact.phone ?? ''),
        trailing: _getSourceIcon(),
        onTap: onTap,
      ),
    );
  }

  Widget _getSourceIcon() {
    switch (contact.source) {
      case 'qr':
        return const Icon(Icons.qr_code, size: 20);
      case 'nfc':
        return const Icon(Icons.nfc, size: 20);
      case 'vcard':
        return const Icon(Icons.description, size: 20);
      default:
        return const Icon(Icons.person, size: 20);
    }
  }
}
