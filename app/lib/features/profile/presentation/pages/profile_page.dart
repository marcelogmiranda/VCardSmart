import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        actions: [
          profileAsync.when(
            data: (profile) => profile != null
                ? IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProfileEditPage(profile: profile),
                        ),
                      );
                    },
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
                      'Crie seu perfil para compartilhar seu cartao digital',
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
              Text('Erro: $e'),
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
