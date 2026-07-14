import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/theme/app_colors.dart';

void main() {
  group('AppColors', () {
    test('should have primary colors defined', () {
      expect(AppColors.primary, isNotNull);
      expect(AppColors.primaryDark, isNotNull);
      expect(AppColors.primaryLight, isNotNull);
    });

    test('should have background colors defined', () {
      expect(AppColors.backgroundLight, isNotNull);
      expect(AppColors.backgroundDark, isNotNull);
    });

    test('should have surface colors defined', () {
      expect(AppColors.surfaceLight, isNotNull);
      expect(AppColors.surfaceDark, isNotNull);
    });

    test('should have status colors defined', () {
      expect(AppColors.success, isNotNull);
      expect(AppColors.error, isNotNull);
      expect(AppColors.warning, isNotNull);
      expect(AppColors.info, isNotNull);
    });
  });
}
