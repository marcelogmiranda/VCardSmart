import '../../domain/entities/nfc_data.dart';

abstract class NFCDataSource {
  Future<bool> checkAvailability();
  Future<void> sendData(NFCData data);
  Future<NFCData> receiveData();
  Future<void> stopSession();
}

class LocalNFCDataSource implements NFCDataSource {
  NFCData? _pendingData;

  @override
  Future<bool> checkAvailability() async {
    return true;
  }

  @override
  Future<void> sendData(NFCData data) async {
    _pendingData = data;
    await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Future<NFCData> receiveData() async {
    await Future.delayed(const Duration(seconds: 2));
    return _pendingData ?? NFCData(
      type: 'profile',
      payload: '{}',
      timestamp: DateTime.now(),
    );
  }

  @override
  Future<void> stopSession() async {
    _pendingData = null;
  }
}
