import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_header.dart';
import 'profile_edit_page.dart';

class ProfilePage extends ConsumerStatefulWidget {
  final String id;

  const ProfilePage({super.key, required this.id});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadOrCreateProfile();
    });
  }

  Future<void> _loadOrCreateProfile() async {
    final notifier = ref.read(profileProvider.notifier);
    if (widget.id.isNotEmpty) {
      await notifier.loadProfile(widget.id);
    } else {
      final profiles = await ref.read(getAllProfilesUseCaseProvider).call();
      if (profiles.isNotEmpty) {
        await notifier.loadProfile(profiles.first.id);
      }
    }
  }

  String _buildVCardData(dynamic profile) {
    final sb = StringBuffer()
      ..writeln('BEGIN:VCARD')
      ..writeln('VERSION:3.0')
      ..writeln('FN:${profile.name}')
      ..writeln('N:${profile.name};;;;');

    if (profile.email != null && profile.email!.isNotEmpty) {
      sb.writeln('EMAIL:${profile.email}');
    }
    if (profile.phone != null && profile.phone!.isNotEmpty) {
      sb.writeln('TEL:${profile.phone}');
    }
    if (profile.website != null && profile.website!.isNotEmpty) {
      sb.writeln('URL:${profile.website}');
    }
    if (profile.linkedin != null && profile.linkedin!.isNotEmpty) {
      sb.writeln('X-LINKEDIN:${profile.linkedin}');
    }
    if (profile.instagram != null && profile.instagram!.isNotEmpty) {
      sb.writeln('X-INSTAGRAM:${profile.instagram}');
    }
    if (profile.facebook != null && profile.facebook!.isNotEmpty) {
      sb.writeln('X-FACEBOOK:${profile.facebook}');
    }
    if (profile.x != null && profile.x!.isNotEmpty) {
      sb.writeln('X-TWITTER:${profile.x}');
    }
    if (profile.social != null && profile.social!.isNotEmpty) {
      sb.writeln('X-SOCIAL:${profile.social}');
    }
    if (profile.bio != null && profile.bio!.isNotEmpty) {
      sb.writeln('NOTE:${profile.bio}');
    }
    if (profile.photoPath != null && profile.photoPath!.isNotEmpty) {
      final file = File(profile.photoPath!);
      if (file.existsSync()) {
        final bytes = file.readAsBytesSync();
        final base64Photo = base64Encode(bytes);
        sb.writeln('PHOTO;ENCODING=b64;TYPE=JPEG:$base64Photo');
      }
    }

    sb.writeln('END:VCARD');
    return sb.toString();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          profileAsync.when(
            data: (profile) => profile != null
                ? Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.qr_code),
                        tooltip: 'Meu QR Code',
                        onPressed: () => context.push('/qr/share'),
                      ),
                      IconButton(
                        icon: const Icon(Icons.share),
                        tooltip: 'Compartilhar',
                        onPressed: () {
                          final vCard = _buildVCardData(profile);
                          Share.share(
                            vCard,
                            subject: '${profile.name} - Cartão VCardSmart',
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        tooltip: 'Editar',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProfileEditPage(profile: profile),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: profileAsync.when(
        data: (profile) => profile != null
            ? SingleChildScrollView(
                child: ProfileHeader(profile: profile),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add, size: 64, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(height: 16),
                    Text(
                      'Nenhum perfil encontrado',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Crie seu perfil para compartilhar seu cartão digital',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileEditPage(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Criar Meu Perfil'),
                    ),
                  ],
                ),
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Não foi possível carregar seus dados'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _loadOrCreateProfile(),
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
