import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/constants/app_constants.dart';

void main() {
  group('AppConstants', () {
    test('should have correct app name', () {
      expect(AppConstants.appName, 'VCardSmart');
    });

    test('should have correct app version', () {
      expect(AppConstants.appVersion, '1.0.0');
    });

    test('should have correct hive box names', () {
      expect(AppConstants.profileBox, 'profiles');
      expect(AppConstants.contactBox, 'contacts');
      expect(AppConstants.settingsBox, 'settings');
      expect(AppConstants.historyBox, 'history');
    });

    test('should have correct route constants', () {
      expect(AppConstants.homeRoute, '/');
      expect(AppConstants.profileRoute, '/profile');
      expect(AppConstants.settingsRoute, '/settings');
    });
  });
}
