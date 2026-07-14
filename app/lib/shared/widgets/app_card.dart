import 'package:flutter/material.dart';
import '../../core/theme/app_shadows.dart';
import '../../core/theme/app_borders.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color ?? Theme.of(context).colorScheme.surface,
          borderRadius: AppBorders.radiusMedium,
          boxShadow: AppShadows.small,
        ),
        child: ClipRRect(
          borderRadius: AppBorders.radiusMedium,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}
