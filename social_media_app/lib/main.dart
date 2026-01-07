import 'package:flutter/material.dart';
import 'package:social_media_app/app/auth_gate.dart';
import 'package:social_media_app/core/constants/supabase_config.dart';
import 'package:social_media_app/core/di/service_locator.dart';
import 'package:social_media_app/core/services/preference_manager.dart';
import 'package:social_media_app/core/theme/dark_theme.dart';
import 'package:social_media_app/core/theme/light_theme.dart';
import 'package:social_media_app/core/theme/theme_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManager().init();
  await ThemeController().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
  );
  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ThemeController.themeNotifier,
      builder: (_, value, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Social',
          themeMode: value,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: AuthGate(),
        );
      },
    );

  }}