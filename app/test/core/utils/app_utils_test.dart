import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/core/utils/app_utils.dart';

void main() {
  group('AppUtils', () {
    test('formatDate should return correct format', () {
      final date = DateTime(2024, 1, 15);
      expect(AppUtils.formatDate(date), '15/01/2024');
    });

    test('formatDateTime should return correct format', () {
      final date = DateTime(2024, 1, 15, 14, 30);
      expect(AppUtils.formatDateTime(date), '15/01/2024 14:30');
    });

    test('truncate should truncate long text', () {
      expect(AppUtils.truncate('Hello World', 5), 'Hello...');
      expect(AppUtils.truncate('Hi', 5), 'Hi');
    });

    test('formatRelative should handle different time ranges', () {
      final now = DateTime.now();

      expect(AppUtils.formatRelative(now), 'Agora');

      final minutesAgo = now.subtract(const Duration(minutes: 5));
      expect(AppUtils.formatRelative(minutesAgo), '5 minuto(s) atrás');

      final hoursAgo = now.subtract(const Duration(hours: 2));
      expect(AppUtils.formatRelative(hoursAgo), '2 hora(s) atrás');

      final daysAgo = now.subtract(const Duration(days: 3));
      expect(AppUtils.formatRelative(daysAgo), '3 dia(s) atrás');

      final monthsAgo = now.subtract(const Duration(days: 60));
      expect(AppUtils.formatRelative(monthsAgo), '2 mês(es) atrás');

      final yearsAgo = now.subtract(const Duration(days: 400));
      expect(AppUtils.formatRelative(yearsAgo), '1 ano(s) atrás');
    });
  });
}
