import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
import '../../../features/profile/presentation/pages/profile_edit_page.dart';
import '../../../features/qr_code/presentation/pages/qr_scan_page.dart';
import '../../../features/nfc/presentation/pages/nfc_receive_page.dart';
import '../../../features/contacts/presentation/pages/contacts_page.dart';
import '../../../features/contacts/presentation/pages/import_page.dart';
import '../../../features/settings/presentation/pages/settings_page.dart';
import '../constants/app_constants.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppConstants.homeRoute,
    routes: [
      GoRoute(
        path: AppConstants.homeRoute,
        builder: (context, state) => const HomePage(),
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
        path: AppConstants.qrScanRoute,
        builder: (context, state) => const QRScanPage(),
      ),
      GoRoute(
        path: AppConstants.nfcReceiveRoute,
        builder: (context, state) => const NFCReceivePage(),
      ),
      GoRoute(
        path: AppConstants.contactsRoute,
        builder: (context, state) => const ContactsPage(),
      ),
      GoRoute(
        path: AppConstants.importRoute,
        builder: (context, state) => const ImportPage(),
      ),
      GoRoute(
        path: AppConstants.settingsRoute,
        builder: (context, state) => const SettingsPage(),
      ),
    ],
  );
});
