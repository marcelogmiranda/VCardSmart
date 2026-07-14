import 'package:flutter/material.dart';
import '../../domain/entities/profile.dart';

class ProfileCard extends StatelessWidget {
  final Profile profile;
  final VoidCallback? onTap;

  const ProfileCard({
    super.key,
    required this.profile,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(
            profile.name.isNotEmpty ? profile.name[0].toUpperCase() : '?',
          ),
        ),
        title: Text(profile.name),
        subtitle: Text(profile.email ?? 'Sem email'),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
