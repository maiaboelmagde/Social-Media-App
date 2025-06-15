import 'package:flutter/material.dart';
import 'package:social_media_app/core/constants/preferences_keys.dart';
import 'package:social_media_app/core/services/preference_manager.dart';

class ThemeController {
  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

  init() {
    bool result = PreferencesManager().getBool(PreferencesKeys.theme) ?? true;
    themeNotifier.value = result ? ThemeMode.dark : ThemeMode.light;
  }

  static toggleTheme() async {
    if (themeNotifier.value == ThemeMode.dark) {
      themeNotifier.value = ThemeMode.light;
      await PreferencesManager().setBool(PreferencesKeys.theme, false);
    } else {
      themeNotifier.value = ThemeMode.dark;
      await PreferencesManager().setBool(PreferencesKeys.theme, true);
    }
  }

  static bool isDark() => themeNotifier.value == ThemeMode.dark;
}