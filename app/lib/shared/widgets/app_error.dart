import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'app_button.dart';

class AppError extends StatelessWidget {
  final String message;
  final String? title;
  final VoidCallback? onRetry;

  const AppError({
    super.key,
    required this.message,
    this.title,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: AppColors.error.withValues(alpha: 0.7),
            ),
            const SizedBox(height: 16),
            Text(
              title ?? 'Erro',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              AppButton(
                label: 'Tentar novamente',
                onPressed: onRetry,
                type: ButtonType.outline,
                icon: Icons.refresh,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AppEmpty extends StatelessWidget {
  final String message;
  final IconData icon;
  final VoidCallback? onAction;
  final String? actionLabel;

  const AppEmpty({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.onAction,
    this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (onAction != null && actionLabel != null) ...[
              const SizedBox(height: 24),
              AppButton(
                label: actionLabel!,
                onPressed: onAction,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
