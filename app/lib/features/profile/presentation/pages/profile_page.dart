import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_header.dart';
import 'profile_edit_page.dart';

class ProfilePage extends ConsumerWidget {
  final String id;

  const ProfilePage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            : const Center(child: Text('Nenhum perfil encontrado')),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Erro: $e'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () =>
                    ref.read(profileProvider.notifier).loadProfile(id),
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
