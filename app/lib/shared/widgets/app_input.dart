import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? error;
  final TextEditingController? controller;
  final bool obscure;
  final TextInputType? keyboardType;
  final Widget? prefix;
  final Widget? suffix;
  final int maxLines;
  final bool enabled;
  final ValueChanged<String>? onChanged;

  const AppInput({
    super.key,
    this.label,
    this.hint,
    this.error,
    this.controller,
    this.obscure = false,
    this.keyboardType,
    this.prefix,
    this.suffix,
    this.maxLines = 1,
    this.enabled = true,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 4),
        ],
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          maxLines: maxLines,
          enabled: enabled,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            errorText: error,
            prefixIcon: prefix,
            suffixIcon: suffix,
          ),
        ),
      ],
    );
  }
}
