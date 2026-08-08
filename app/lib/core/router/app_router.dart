import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
import '../../../features/profile/presentation/pages/profile_edit_page.dart';
import '../../../features/qr_code/presentation/pages/qr_scan_page.dart';
import '../../../features/qr_code/presentation/pages/qr_share_page.dart';
import '../../../features/nfc/presentation/pages/nfc_receive_page.dart';
import '../../../features/nfc/presentation/pages/nfc_share_page.dart';
import '../../../features/contacts/presentation/pages/contacts_page.dart';
import '../../../features/contacts/presentation/pages/import_page.dart';
import '../../../features/settings/presentation/pages/settings_page.dart';
import '../../../features/security/presentation/pages/auth_page.dart';
import '../../../features/security/presentation/pages/pin_setup_page.dart';
import '../../../features/security/presentation/pages/security_setup_page.dart';
import '../../../features/security/presentation/providers/auth_provider.dart';
import '../../../features/settings/presentation/providers/settings_provider.dart';
import '../constants/app_constants.dart';
import 'shell_page.dart';

String? authRedirect(AuthStatus status, String location) {
  final isAuthPage = location == AppConstants.authRoute;
  final isSetupPage = location == AppConstants.securitySetupRoute;
  final isPinSetupPage = location == AppConstants.pinSetupRoute;

  if (status.needsSetup) {
    final isSetupFlow = isSetupPage || isPinSetupPage;
    return isSetupFlow ? null : AppConstants.securitySetupRoute;
  }

  if (status.state == AuthState.checking) {
    return isAuthPage ? null : AppConstants.authRoute;
  }

  if (status.state == AuthState.authenticated) {
    return (isAuthPage || isSetupPage) ? AppConstants.homeRoute : null;
  }

  return isAuthPage ? null : AppConstants.authRoute;
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  final refresh = ValueNotifier<int>(0);
  void onAuthChanged(AuthStatus _) => refresh.value++;
  final removeListener =
      authNotifier.addListener(onAuthChanged, fireImmediately: false);

  Future<void> runCheckAuth() async {
    final settings = await ref.read(getSettingsUseCaseProvider)();
    await authNotifier.checkAuth(settings);
  }
  Future.microtask(runCheckAuth);

  ref.onDispose(() {
    removeListener();
    refresh.dispose();
  });
  return GoRouter(
    initialLocation: AppConstants.homeRoute,
    redirect: (context, state) =>
        authRedirect(ref.read(authProvider), state.matchedLocation),
    refreshListenable: refresh,
    routes: [
      GoRoute(
        path: AppConstants.authRoute,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: AppConstants.securitySetupRoute,
        builder: (context, state) => const SecuritySetupPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => ShellPage(child: child),
        routes: [
          GoRoute(
            path: AppConstants.homeRoute,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: AppConstants.contactsRoute,
            builder: (context, state) => const ContactsPage(),
          ),
          GoRoute(
            path: AppConstants.settingsRoute,
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
      GoRoute(
        path: AppConstants.profileRoute,
        builder: (context, state) {
          final id = state.uri.queryParameters['id'] ?? '';
          return ProfilePage(id: id);
        },
      ),
      GoRoute(
        path: '${AppConstants.profileRoute}/edit',
        builder: (context, state) => const ProfileEditPage(),
      ),
      GoRoute(
        path: AppConstants.qrShareRoute,
        builder: (context, state) => const QRSharePage(),
      ),
      GoRoute(
        path: AppConstants.qrScanRoute,
        builder: (context, state) => const QRScanPage(),
      ),
      GoRoute(
        path: AppConstants.nfcReceiveRoute,
        builder: (context, state) => const NFCReceivePage(),
      ),
      GoRoute(
        path: AppConstants.nfcShareRoute,
        builder: (context, state) => const NFCShareRoutePage(),
      ),
      GoRoute(
        path: AppConstants.importRoute,
        builder: (context, state) => const ImportPage(),
      ),
      GoRoute(
        path: AppConstants.pinSetupRoute,
        builder: (context, state) => const PinSetupPage(),
      ),
    ],
  );
});
