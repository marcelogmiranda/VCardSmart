import 'package:flutter/material.dart';

class ThemeToggle extends StatelessWidget {
  final ThemeMode themeMode;
  final Function(ThemeMode) onChanged;

  const ThemeToggle({
    super.key,
    required this.themeMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.palette),
      title: const Text('Tema'),
      trailing: SegmentedButton<ThemeMode>(
        segments: const [
          ButtonSegment(
            value: ThemeMode.light,
            icon: Icon(Icons.light_mode),
          ),
          ButtonSegment(
            value: ThemeMode.dark,
            icon: Icon(Icons.dark_mode),
          ),
          ButtonSegment(
            value: ThemeMode.system,
            icon: Icon(Icons.settings_brightness),
          ),
        ],
        selected: {themeMode},
        onSelectionChanged: (selected) {
          onChanged(selected.first);
        },
      ),
    );
  }
}
