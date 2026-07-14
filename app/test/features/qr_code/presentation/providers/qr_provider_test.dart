import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcardsmart/features/qr_code/presentation/providers/qr_provider.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

void main() {
  group('QRState', () {
    test('should have default values', () {
      const state = QRState();

      expect(state.qrData, isNull);
      expect(state.scannedProfile, isNull);
      expect(state.isScanning, false);
      expect(state.error, isNull);
    });

    test('copyWith should create new state with updated values', () {
      const state = QRState();
      final updated = state.copyWith(
        qrData: 'test',
        isScanning: true,
      );

      expect(updated.qrData, 'test');
      expect(updated.isScanning, true);
      expect(updated.error, isNull);
    });

    test('copyWith should clear error when error is null', () {
      const state = QRState(error: 'old error');
      final updated = state.copyWith();

      expect(updated.error, isNull);
    });
  });

  group('QRNotifier', () {
    test('should have initial state', () {
      final container = ProviderContainer();
      final state = container.read(qrProvider);

      expect(state.qrData, isNull);
      expect(state.scannedProfile, isNull);
      expect(state.isScanning, false);
      container.dispose();
    });

    test('reset should clear state', () async {
      final container = ProviderContainer();
      final notifier = container.read(qrProvider.notifier);

      await notifier.generateQR(
        Profile(
          id: '1',
          name: 'Test',
          createdAt: DateTime(2024),
          updatedAt: DateTime(2024),
        ),
      );

      notifier.reset();
      final state = container.read(qrProvider);

      expect(state.qrData, isNull);
      expect(state.scannedProfile, isNull);
      container.dispose();
    });
  });
}
