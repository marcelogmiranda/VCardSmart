import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/database/hive_boxes.dart';

void main() {
  group('HiveBoxes', () {
    test('should have correct box names', () {
      expect(HiveBoxes.profiles, 'profiles');
      expect(HiveBoxes.contacts, 'contacts');
      expect(HiveBoxes.settings, 'settings');
      expect(HiveBoxes.history, 'history');
    });
  });
}
