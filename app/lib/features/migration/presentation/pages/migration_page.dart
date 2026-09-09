import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vcardsmart/features/migration/presentation/providers/migration_provider.dart';

class MigrationPage extends ConsumerStatefulWidget {
  const MigrationPage({super.key});

  @override
  ConsumerState<MigrationPage> createState() => _MigrationPageState();
}

class _MigrationPageState extends ConsumerState<MigrationPage> {
  bool _busy = false;

  Future<void> _exportBackup() async {
    final passphrase = await _askPassphrase(context, isImport: false);
    if (passphrase == null) return;
    if (passphrase.length < 4) {
      _showMessage('A senha deve ter pelo menos 4 caracteres');
      return;
    }

    setState(() => _busy = true);
    try {
      final docsDir = await getApplicationDocumentsDirectory();
      final file = File(
        '${docsDir.path}/VCardSmart_backup_${DateTime.now().millisecondsSinceEpoch}.vcs',
      );
      await ref.read(exportBackupUseCaseProvider).call(passphrase, file.path);
      await Share.shareXFiles(
        [XFile(file.path, mimeType: 'application/octet-stream')],
        text: 'Backup VCardSmart',
      );
      _showMessage('Backup exportado com sucesso!');
    } catch (e) {
      _showMessage(
        'Não foi possível exportar o backup. ${_friendlyError(e)}',
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _importBackup() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['vcs'],
    );
    if (result == null || result.files.single.path == null) return;
    if (!mounted) return;

    final passphrase = await _askPassphrase(context, isImport: true);
    if (passphrase == null) return;
    if (!mounted) return;

    final proceed = await _confirmRestore(context);
    if (!proceed) return;

    setState(() => _busy = true);
    try {
      await ref
          .read(importBackupUseCaseProvider)
          .call(result.files.single.path!, passphrase);
      if (mounted) {
        _showMessage('Dados restaurados com sucesso!');
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      _showMessage(
        'Não foi possível importar o backup. ${_friendlyError(e)}',
      );
      if (mounted) setState(() => _busy = false);
    }
  }

  String _friendlyError(Object error) {
    if (error is FormatException) {
      return 'A senha está incorreta ou o arquivo está corrompido.';
    }
    if (error is FileSystemException) {
      return 'Não foi possível acessar o arquivo.';
    }
    return 'Ocorreu um erro inesperado. Tente novamente.';
  }

  Future<void> _showMessage(String message) async {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Migração de Dispositivo')),
      body: _busy
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(color: theme.colorScheme.outlineVariant),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.devices,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Migre seus dados para outro aparelho',
                          style: theme.textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Exporte um backup criptografado com seus dados, '
                          'perfis e configurações — incluindo seu PIN — e '
                          'importe no novo dispositivo. O arquivo é protegido '
                          'por uma senha que você escolhe.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _busy ? null : _exportBackup,
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Exportar backup'),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: _busy ? null : _importBackup,
                  icon: const Icon(Icons.download),
                  label: const Text('Importar backup'),
                ),
                const SizedBox(height: 24),
                Text(
                  'Dica: use o backup ao trocar de celular. O PIN é '
                  'reutilizado no novo aparelho, mas a biometria precisa ser '
                  'reconfigurada.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ],
            ),
    );
  }
}

Future<String?> _askPassphrase(
  BuildContext context, {
  required bool isImport,
}) async {
  final controller = TextEditingController();
  final confirmedController = TextEditingController();
  final useConfirm = !isImport;
  var obscure = true;

  final result = await showDialog<String>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: Text(
            isImport
                ? 'Digite a senha do backup'
                : 'Crie uma senha para o backup',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                obscureText: obscure,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscure
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    onPressed: () {
                      setState(() => obscure = !obscure);
                    },
                  ),
                ),
              ),
              if (useConfirm) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: confirmedController,
                  obscureText: obscure,
                  decoration: const InputDecoration(
                    labelText: 'Confirme a senha',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                if (controller.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Informe a senha')),
                  );
                  return;
                }
                if (useConfirm && controller.text != confirmedController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('As senhas não coincidem'),
                    ),
                  );
                  return;
                }
                Navigator.of(dialogContext).pop(controller.text);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    ),
  );
  return result;
}

Future<bool> _confirmRestore(BuildContext context) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Restaurar dados?'),
      content: const Text(
        'A importação substituirá todos os perfis e contatos atuais '
        'pelos dados do backup. Deseja continuar?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: const Text('Restaurar'),
        ),
      ],
    ),
  );
  return result ?? false;
}
