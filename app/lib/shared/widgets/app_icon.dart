import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Color? color;

  const AppIcon({
    super.key,
    required this.icon,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color ?? Theme.of(context).iconTheme.color,
    );
  }
}

class AppStatusIcon extends StatelessWidget {
  final IconData icon;
  final StatusType type;

  const AppStatusIcon({
    super.key,
    required this.icon,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final color = switch (type) {
      StatusType.success => AppColors.success,
      StatusType.error => AppColors.error,
      StatusType.warning => AppColors.warning,
      StatusType.info => AppColors.info,
    };

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: color, size: 24),
    );
  }
}

enum StatusType { success, error, warning, info }
