import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'core/database/hive_service.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  try {
    await MobileAds.instance.initialize();
  } catch (_) {}
  runApp(
    const ProviderScope(
      child: VCardSmartApp(),
    ),
  );
}
