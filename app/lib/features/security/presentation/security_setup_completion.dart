import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../settings/presentation/providers/settings_provider.dart';
import 'providers/auth_provider.dart';

Future<void> completeSecuritySetup(
  WidgetRef ref,
  BuildContext context, {
  bool enableBiometric = false,
  bool enablePin = false,
  int? pinLength,
}) async {
  final settingsNotifier = ref.read(settingsProvider.notifier);
  if (enableBiometric) {
    await settingsNotifier.updateBiometric(true);
  }
  if (enablePin) {
    await settingsNotifier.updatePin(true);
    if (pinLength != null) {
      await settingsNotifier.updatePinLength(pinLength);
    }
  }
  await settingsNotifier.markSecurityAsked();
  final settings = ref.read(settingsProvider);
  await ref.read(authProvider.notifier).checkAuth(settings);
  if (context.mounted) {
    context.go(AppConstants.homeRoute);
  }
}
