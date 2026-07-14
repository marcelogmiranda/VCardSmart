import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/theme/app_spacing.dart';

void main() {
  group('AppSpacing', () {
    test('should have correct spacing values', () {
      expect(AppSpacing.xs, 4);
      expect(AppSpacing.sm, 8);
      expect(AppSpacing.md, 16);
      expect(AppSpacing.lg, 24);
      expect(AppSpacing.xl, 32);
      expect(AppSpacing.xxl, 48);
    });
  });
}
