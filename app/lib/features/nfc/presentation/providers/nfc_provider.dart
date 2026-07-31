import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/send_nfc_usecase.dart';
import '../../domain/usecases/receive_nfc_usecase.dart';
import '../../data/datasources/nfc_datasource.dart';
import '../../data/repositories/local_nfc_repository.dart';
import '../../domain/repositories/nfc_repository.dart';
import '../../../profile/domain/entities/profile.dart';

enum NFCState { idle, ready, sending, receiving, success, error }

class NFCStatus {
  final NFCState state;
  final Profile? profile;
  final String? error;
  final bool isAvailable;

  const NFCStatus({
    this.state = NFCState.idle,
    this.profile,
    this.error,
    this.isAvailable = false,
  });

  NFCStatus copyWith({
    NFCState? state,
    Profile? profile,
    String? error,
    bool? isAvailable,
  }) {
    return NFCStatus(
      state: state ?? this.state,
      profile: profile ?? this.profile,
      error: error,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }
}

final nfcDataSourceProvider = Provider<NFCDataSource>((ref) {
  return LocalNFCDataSource();
});

final nfcRepositoryProvider = Provider((ref) {
  final dataSource = ref.read(nfcDataSourceProvider);
  return LocalNFCRepository(dataSource);
});

final sendNFCUseCaseProvider = Provider((ref) {
  return SendNFCUseCase(ref.read(nfcRepositoryProvider));
});

final receiveNFCUseCaseProvider = Provider((ref) {
  return ReceiveNFCUseCase(ref.read(nfcRepositoryProvider));
});

class NFCNotifier extends StateNotifier<NFCStatus> {
  final SendNFCUseCase _sendNFC;
  final ReceiveNFCUseCase _receiveNFC;
  final NFCRepository _repository;

  NFCNotifier(this._sendNFC, this._receiveNFC, this._repository)
      : super(const NFCStatus());

  Future<void> checkAvailability() async {
    final available = await _repository.isAvailable();
    state = state.copyWith(isAvailable: available);
  }

  Future<void> send(Profile profile) async {
    state = state.copyWith(state: NFCState.sending, error: null);
    try {
      await _sendNFC(profile);
      state = state.copyWith(state: NFCState.success);
    } catch (e) {
      state = state.copyWith(state: NFCState.error, error: e.toString());
    }
  }

  Future<void> receive() async {
    state = state.copyWith(state: NFCState.receiving, error: null);
    try {
      final profile = await _receiveNFC();
      state = state.copyWith(state: NFCState.success, profile: profile);
    } catch (e) {
      state = state.copyWith(state: NFCState.error, error: e.toString());
    }
  }

  void reset() {
    state = const NFCStatus();
  }

  void setUnavailable() {
    state = state.copyWith(isAvailable: false);
  }
}

final nfcProvider = StateNotifierProvider<NFCNotifier, NFCStatus>((ref) {
  return NFCNotifier(
    ref.read(sendNFCUseCaseProvider),
    ref.read(receiveNFCUseCaseProvider),
    ref.read(nfcRepositoryProvider),
  );
});
