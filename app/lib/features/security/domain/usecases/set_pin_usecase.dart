import '../../../../core/security/pin_service.dart';

class SetPinUseCase {
  Future<void> call(String pin) async {
    if (pin.length < 4) {
      throw Exception('PIN deve ter pelo menos 4 dígitos');
    }
    await PinService.setPin(pin);
  }

  Future<bool> hasPin() async {
    return await PinService.hasPin();
  }

  Future<void> removePin() async {
    await PinService.removePin();
  }
}
