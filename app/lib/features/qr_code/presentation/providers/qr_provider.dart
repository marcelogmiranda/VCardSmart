import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/usecases/generate_qr_usecase.dart';
import '../../domain/usecases/scan_qr_usecase.dart';
import '../../data/datasources/qr_datasource.dart';
import '../../data/repositories/local_qr_repository.dart';
import '../../../profile/domain/entities/profile.dart';

final qrDataSourceProvider = Provider<QRDataSource>((ref) {
  return LocalQRDataSource();
});

final qrRepositoryProvider = Provider((ref) {
  final dataSource = ref.read(qrDataSourceProvider);
  return LocalQRRepository(dataSource);
});

final generateQRUseCaseProvider = Provider((ref) {
  return GenerateQRUseCase(ref.read(qrRepositoryProvider));
});

final scanQRUseCaseProvider = Provider((ref) {
  return ScanQRUseCase(ref.read(qrRepositoryProvider));
});

class QRState {
  final String? qrData;
  final Profile? scannedProfile;
  final bool isScanning;
  final String? error;

  const QRState({
    this.qrData,
    this.scannedProfile,
    this.isScanning = false,
    this.error,
  });

  QRState copyWith({
    String? qrData,
    Profile? scannedProfile,
    bool? isScanning,
    String? error,
  }) {
    return QRState(
      qrData: qrData ?? this.qrData,
      scannedProfile: scannedProfile ?? this.scannedProfile,
      isScanning: isScanning ?? this.isScanning,
      error: error,
    );
  }
}

class QRNotifier extends StateNotifier<QRState> {
  final GenerateQRUseCase _generateQR;
  final ScanQRUseCase _scanQR;

  QRNotifier(this._generateQR, this._scanQR) : super(const QRState());

  Future<void> generateQR(Profile profile) async {
    try {
      final data = await _generateQR(profile);
      state = state.copyWith(qrData: data);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> scanQR(String data) async {
    state = state.copyWith(isScanning: true, error: null);
    try {
      final profile = await _scanQR(data);
      state = state.copyWith(
        scannedProfile: profile,
        isScanning: false,
      );
    } catch (e) {
      state = state.copyWith(
        isScanning: false,
        error: e.toString(),
      );
    }
  }

  void reset() {
    state = const QRState();
  }
}

final qrProvider = StateNotifierProvider<QRNotifier, QRState>((ref) {
  return QRNotifier(
    ref.read(generateQRUseCaseProvider),
    ref.read(scanQRUseCaseProvider),
  );
});
