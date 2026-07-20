import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
              'Acoes Rapidas',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _ActionGrid(colorScheme: colorScheme),
            const SizedBox(height: 24),
            Text(
              'Como Funciona',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _HowItWorksCard(colorScheme: colorScheme),
          ],
        ),
      ),
    );
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
                    'Meu Cartao',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Crie e compartilhe seu cartao digital',
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
    );
  }
}

class _ActionGrid extends StatelessWidget {
  final ColorScheme colorScheme;

  const _ActionGrid({required this.colorScheme});

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
          title: 'QR Code',
          subtitle: 'Gerar ou escanear',
          color: colorScheme.primaryContainer,
          iconColor: colorScheme.onPrimaryContainer,
          onTap: () => context.push('/qr/scan'),
        ),
        _ActionCard(
          icon: Icons.nfc,
          title: 'NFC',
          subtitle: 'Compartilhar por NFC',
          color: colorScheme.secondaryContainer,
          iconColor: colorScheme.onSecondaryContainer,
          onTap: () => context.push('/nfc/receive'),
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
          subtitle: 'Enviar meu cartao',
          color: colorScheme.errorContainer,
          iconColor: colorScheme.onErrorContainer,
          onTap: () => context.push('/profile'),
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

class _HowItWorksCard extends StatelessWidget {
  final ColorScheme colorScheme;

  const _HowItWorksCard({required this.colorScheme});

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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _StepRow(
              step: '1',
              title: 'Crie seu perfil',
              description: 'Adicione seus dados de contato',
              colorScheme: colorScheme,
            ),
            const Divider(height: 24),
            _StepRow(
              step: '2',
              title: 'Gere seu QR Code',
              description: 'Gere um QR Code com seu cartao',
              colorScheme: colorScheme,
            ),
            const Divider(height: 24),
            _StepRow(
              step: '3',
              title: 'Compartilhe',
              description: 'Escaneie, use NFC ou envie por mensagem',
              colorScheme: colorScheme,
            ),
          ],
        ),
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final String step;
  final String title;
  final String description;
  final ColorScheme colorScheme;

  const _StepRow({
    required this.step,
    required this.title,
    required this.description,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: colorScheme.primaryContainer,
          child: Text(
            step,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimaryContainer,
              fontSize: 13,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              Text(
                description,
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
