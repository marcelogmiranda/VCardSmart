import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vcardsmart/features/nfc/presentation/providers/nfc_provider.dart';
import 'package:vcardsmart/features/profile/domain/entities/profile.dart';

import '../../nfc_channel_mock.dart';

void main() {
  late ProviderContainer container;
  late NfcChannelMock nfcMock;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    nfcMock = NfcChannelMock()..install();
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

    test('checkAvailability should set isAvailable to false when unavailable',
        () async {
      nfcMock.available = false;
      final notifier = container.read(nfcProvider.notifier);
      await notifier.checkAvailability();

      expect(notifier.state.isAvailable, false);
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
      nfcMock.writtenPayloads
          .add('{"name":"Received User","email":"r@test.com"}');
      final notifier = container.read(nfcProvider.notifier);

      await notifier.receive();

      expect(notifier.state.state, NFCState.success);
      expect(notifier.state.profile, isNotNull);
      expect(notifier.state.profile!.name, 'Received User');
      expect(notifier.state.profile!.email, 'r@test.com');
    });

    test('receive should set error state on failure', () async {
      final notifier = container.read(nfcProvider.notifier);

      await notifier.receive();

      expect(notifier.state.state, NFCState.error);
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
      expect(notifier.state.profile!.name, 'Sequential Test');
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
