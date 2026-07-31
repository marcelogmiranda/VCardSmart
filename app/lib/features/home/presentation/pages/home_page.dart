import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../profile/presentation/providers/profile_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('VCardSmart'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            onPressed: () => context.push('/profile'),
            tooltip: 'Meu Perfil',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProfileCard(colorScheme: colorScheme),
            const SizedBox(height: 24),
            Text(
              'Ações Rápidas',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _ActionGrid(
              colorScheme: colorScheme,
              onShare: () => _shareProfile(context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _shareProfile(BuildContext context, WidgetRef ref) async {
    final profiles = await ref.read(getAllProfilesUseCaseProvider).call();
    if (!context.mounted) return;

    if (profiles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Crie seu perfil primeiro')),
      );
      context.push('/profile');
      return;
    }

    context.push('/qr/share');
  }
}

class _ProfileCard extends StatelessWidget {
  final ColorScheme colorScheme;

  const _ProfileCard({required this.colorScheme});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outlineVariant,
          width: 1,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => context.push('/profile'),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              CircleAvatar(
                radius: 32,
                backgroundColor: colorScheme.primaryContainer,
                child: Icon(
                  Icons.person,
                  size: 32,
                  color: colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Meu Cartão',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Crie e compartilhe seu cartão digital',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionGrid extends StatelessWidget {
  final ColorScheme colorScheme;
  final VoidCallback onShare;

  const _ActionGrid({required this.colorScheme, required this.onShare});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.1,
      children: [
        _ActionCard(
          icon: Icons.qr_code,
          title: 'Meu QR Code',
          subtitle: 'Gerar para compartilhar',
          color: colorScheme.primaryContainer,
          iconColor: colorScheme.onPrimaryContainer,
          onTap: () => context.push('/qr/share'),
        ),
        _ActionCard(
          icon: Icons.qr_code_scanner,
          title: 'Escanear',
          subtitle: 'Ler QR Code',
          color: colorScheme.secondaryContainer,
          iconColor: colorScheme.onSecondaryContainer,
          onTap: () => context.push('/qr/scan'),
        ),
        _ActionCard(
          icon: Icons.file_upload_outlined,
          title: 'Importar',
          subtitle: 'Arquivo vCard',
          color: colorScheme.tertiaryContainer,
          iconColor: colorScheme.onTertiaryContainer,
          onTap: () => context.push('/contacts/import'),
        ),
        _ActionCard(
          icon: Icons.share_outlined,
          title: 'Compartilhar',
          subtitle: 'Enviar meu cartão',
          color: colorScheme.errorContainer,
          iconColor: colorScheme.onErrorContainer,
          onTap: onShare,
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Color iconColor;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: color,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: iconColor),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: iconColor.withValues(alpha: 0.7),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


