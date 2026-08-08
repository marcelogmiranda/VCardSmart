import '../../../../core/security/pin_service.dart';

class SetPinUseCase {
  Future<void> call(String pin, {int length = 6}) async {
    if (pin.length != length) {
      throw Exception('O PIN deve ter $length dígitos');
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
