import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final EdgeInsetsGeometry margin;

  const AppDivider({
    super.key,
    this.height = 1,
    this.thickness = 1,
    this.margin = const EdgeInsets.symmetric(vertical: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Divider(
        height: height,
        thickness: thickness,
        color: Theme.of(context).dividerColor,
      ),
    );
  }
}
