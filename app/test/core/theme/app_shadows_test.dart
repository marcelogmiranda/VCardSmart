import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/theme/app_shadows.dart';

void main() {
  group('AppShadows', () {
    test('should have small shadow', () {
      final shadows = AppShadows.small;
      expect(shadows, isNotEmpty);
      expect(shadows.first.blurRadius, 2);
    });

    test('should have medium shadow', () {
      final shadows = AppShadows.medium;
      expect(shadows, isNotEmpty);
      expect(shadows.first.blurRadius, 4);
    });

    test('should have large shadow', () {
      final shadows = AppShadows.large;
      expect(shadows, isNotEmpty);
      expect(shadows.first.blurRadius, 8);
    });
  });
}
