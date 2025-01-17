import 'package:flutter/material.dart';
import 'package:routing_app/repositories/shared_preferences/shared_preferences_repo.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeMode themeMode = getThemeMode();

  ThemeMode getThemeMode() {
    int themeValue = SharedPreferencesRepo.instance.getThemeValue();

    if (themeValue > -1 && themeValue < ThemeMode.values.length) {
      return ThemeMode.values[themeValue];
    }

    return ThemeMode.light;
  }

  void changeTheme(ThemeMode themeMode) {
    this.themeMode = themeMode;
    SharedPreferencesRepo.instance.setThemeValue(themeMode.index);
    notifyListeners();
  }

  void toggleTheme() {
    changeTheme(themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  bool get darkMode => themeMode == ThemeMode.dark;
}