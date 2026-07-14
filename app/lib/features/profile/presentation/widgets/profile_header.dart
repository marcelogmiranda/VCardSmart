import 'package:flutter/material.dart';
import '../../domain/entities/profile.dart';

class ProfileHeader extends StatelessWidget {
  final Profile profile;

  const ProfileHeader({
    super.key,
    required this.profile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            child: Text(
              profile.name.isNotEmpty ? profile.name[0].toUpperCase() : '?',
              style: const TextStyle(fontSize: 32),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            profile.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          if (profile.email != null && profile.email!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              profile.email!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
          if (profile.phone != null && profile.phone!.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              profile.phone!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
