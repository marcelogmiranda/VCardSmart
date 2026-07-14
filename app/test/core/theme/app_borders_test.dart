import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/theme/app_borders.dart';

void main() {
  group('AppBorders', () {
    test('should have correct border radius values', () {
      expect(AppBorders.radiusSmall, isNotNull);
      expect(AppBorders.radiusMedium, isNotNull);
      expect(AppBorders.radiusLarge, isNotNull);
      expect(AppBorders.radiusXLarge, isNotNull);
      expect(AppBorders.radiusFull, isNotNull);
    });

    test('should have none border', () {
      expect(AppBorders.none, isNotNull);
    });
  });
}
