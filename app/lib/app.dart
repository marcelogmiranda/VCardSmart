import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/utils/locale_utils.dart';
import 'l10n/app_localizations.dart';
import 'features/settings/presentation/providers/settings_provider.dart';

class VCardSmartApp extends ConsumerWidget {
  const VCardSmartApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final router = ref.watch(appRouterProvider);
        final settings = ref.watch(settingsProvider);
        return MaterialApp.router(
          title: 'VCardSmart',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light(),
          darkTheme: AppTheme.dark(),
          themeMode: settings.themeMode,
          locale: settings.locale,
          supportedLocales: LocaleUtils.supportedLocales,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          routerConfig: router,
        );
      },
    );
  }
}
