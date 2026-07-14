import 'package:flutter/material.dart';
import '../../core/theme/app_text_styles.dart';

enum ButtonType { primary, secondary, outline, text }

class AppButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isLoading;
  final IconData? icon;

  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SizedBox(
        height: 48,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    switch (type) {
      case ButtonType.primary:
        return ElevatedButton(
          onPressed: onPressed,
          child: _buildChild(),
        );
      case ButtonType.secondary:
        return FilledButton(
          onPressed: onPressed,
          child: _buildChild(),
        );
      case ButtonType.outline:
        return OutlinedButton(
          onPressed: onPressed,
          child: _buildChild(),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: onPressed,
          child: _buildChild(),
        );
    }
  }

  Widget _buildChild() {
    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Text(label, style: AppTextStyles.button),
        ],
      );
    }
    return Text(label, style: AppTextStyles.button);
  }
}
