import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/profile.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_form.dart';

class ProfileEditPage extends ConsumerWidget {
  final Profile? profile;

  const ProfileEditPage({super.key, this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(profile != null ? 'Editar Perfil' : 'Novo Perfil'),
      ),
      body: ProfileForm(
        profile: profile,
        onSubmit: (newProfile) async {
          if (profile != null) {
            await ref.read(profileProvider.notifier).updateProfile(newProfile);
          } else {
            await ref.read(profileProvider.notifier).createProfile(newProfile);
          }
          if (context.mounted) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
