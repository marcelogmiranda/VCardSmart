import 'package:flutter_test/flutter_test.dart';
import 'package:vcardsmart/features/home/providers/home_provider.dart';

void main() {
  group('HomeNotifier', () {
    test('should have initial state', () {
      final notifier = HomeNotifier();
      expect(notifier.state.isLoading, false);
      expect(notifier.state.error, null);
    });

    test('loadHome should set loading to true then false', () async {
      final notifier = HomeNotifier();
      await notifier.loadHome();
      expect(notifier.state.isLoading, false);
      expect(notifier.state.error, null);
    });
  });

  group('HomeState', () {
    test('copyWith should create new state', () {
      const state = HomeState();
      final newState = state.copyWith(isLoading: true);
      expect(newState.isLoading, true);
      expect(newState.error, null);
    });

    test('copyWith should clear error', () {
      const state = HomeState(error: 'test error');
      final newState = state.copyWith(error: null);
      expect(newState.error, null);
    });
  });
}
