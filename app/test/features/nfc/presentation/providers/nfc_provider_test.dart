import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcardsmart/features/nfc/presentation/providers/nfc_provider.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('NFCNotifier', () {
    test('should have initial state', () {
      final notifier = container.read(nfcProvider.notifier);
      final state = notifier.state;

      expect(state.state, NFCState.idle);
      expect(state.profile, isNull);
      expect(state.error, isNull);
      expect(state.isAvailable, false);
    });

    test('checkAvailability should set isAvailable to true', () async {
      final notifier = container.read(nfcProvider.notifier);
      await notifier.checkAvailability();

      expect(notifier.state.isAvailable, true);
    });

    test('send should transition through sending to success', () async {
      final notifier = container.read(nfcProvider.notifier);
      final profile = Profile(
        id: '1',
        name: 'Send Test',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await notifier.send(profile);

      expect(notifier.state.state, NFCState.success);
      expect(notifier.state.error, isNull);
    });

    test('receive should transition through receiving to success', () async {
      final notifier = container.read(nfcProvider.notifier);

      await notifier.receive();

      expect(notifier.state.state, NFCState.success);
      expect(notifier.state.profile, isNotNull);
      expect(notifier.state.profile!.name, isNotNull);
    });

    test('reset should restore initial state', () async {
      final notifier = container.read(nfcProvider.notifier);
      await notifier.checkAvailability();
      expect(notifier.state.isAvailable, true);

      notifier.reset();

      expect(notifier.state.state, NFCState.idle);
      expect(notifier.state.isAvailable, false);
      expect(notifier.state.profile, isNull);
    });

    test('receive should update profile in state', () async {
      final notifier = container.read(nfcProvider.notifier);

      await notifier.receive();

      expect(notifier.state.profile, isNotNull);
    });

    test('send then receive should work sequentially', () async {
      final notifier = container.read(nfcProvider.notifier);
      final profile = Profile(
        id: '2',
        name: 'Sequential Test',
        createdAt: DateTime(2024),
        updatedAt: DateTime(2024),
      );

      await notifier.send(profile);
      expect(notifier.state.state, NFCState.success);

      await notifier.receive();
      expect(notifier.state.state, NFCState.success);
      expect(notifier.state.profile, isNotNull);
    });
  });

  group('NFCProviders', () {
    test('nfcDataSourceProvider should provide LocalNFCDataSource', () {
      final ds = container.read(nfcDataSourceProvider);
      expect(ds, isNotNull);
    });

    test('nfcRepositoryProvider should provide LocalNFCRepository', () {
      final repo = container.read(nfcRepositoryProvider);
      expect(repo, isNotNull);
    });

    test('sendNFCUseCaseProvider should provide SendNFCUseCase', () {
      final uc = container.read(sendNFCUseCaseProvider);
      expect(uc, isNotNull);
    });

    test('receiveNFCUseCaseProvider should provide ReceiveNFCUseCase', () {
      final uc = container.read(receiveNFCUseCaseProvider);
      expect(uc, isNotNull);
    });
  });
}
