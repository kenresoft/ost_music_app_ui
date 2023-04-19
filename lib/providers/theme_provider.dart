import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Theme State
class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(true);

  void toggleTheme(bool isDarkEnabled) => state = isDarkEnabled;
}

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});
