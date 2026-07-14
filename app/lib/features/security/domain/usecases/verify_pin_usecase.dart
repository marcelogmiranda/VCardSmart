import '../../../../core/security/pin_service.dart';

class VerifyPinUseCase {
  Future<bool> call(String pin) async {
    return await PinService.verifyPin(pin);
  }
}
