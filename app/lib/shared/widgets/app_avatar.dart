import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final double size;
  final VoidCallback? onTap;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 48,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final child = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.primaryContainer,
        image: imageUrl != null
            ? DecorationImage(
                image: NetworkImage(imageUrl!),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imageUrl == null
          ? Center(
              child: Text(
                initials ?? '?',
                style: TextStyle(
                  fontSize: size * 0.4,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
            )
          : null,
    );

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: child);
    }
    return child;
  }
}
