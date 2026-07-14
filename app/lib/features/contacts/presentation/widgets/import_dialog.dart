import 'package:flutter/material.dart';

class ImportDialog extends StatelessWidget {
  final void Function(String data, String source) onImport;

  const ImportDialog({super.key, required this.onImport});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Importar Contato'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.qr_code),
            title: const Text('Via QR Code'),
            onTap: () {
              Navigator.of(context).pop();
              onImport('', 'qr');
            },
          ),
          ListTile(
            leading: const Icon(Icons.nfc),
            title: const Text('Via NFC'),
            onTap: () {
              Navigator.of(context).pop();
              onImport('', 'nfc');
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Via vCard'),
            onTap: () {
              Navigator.of(context).pop();
              _showVCardImport(context);
            },
          ),
        ],
      ),
    );
  }

  void _showVCardImport(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Colar vCard'),
        content: TextField(
          controller: controller,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: 'Cole o conteúdo vCard aqui...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onImport(controller.text, 'vcard');
            },
            child: const Text('Importar'),
          ),
        ],
      ),
    );
  }
}
