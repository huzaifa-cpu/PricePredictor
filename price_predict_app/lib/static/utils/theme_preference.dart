import 'dart:convert';

import 'package:price_predict_app/dynamic/API/user_repo.dart';
import 'package:price_predict_app/static/utils/app_themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  //
  static SharedPreferences preferences;
  static const String KEY_SELECTED_THEME = 'key_selected_theme';

  static init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static void saveTheme(darkOrLight selectedTheme) async {
    if (null == selectedTheme) {
      selectedTheme = darkOrLight.lightTheme;
    }
    String theme = jsonEncode(selectedTheme.toString());
    preferences.setString(KEY_SELECTED_THEME, theme);
  }

  static darkOrLight getTheme() {
    String theme = preferences.getString(KEY_SELECTED_THEME);
    if (null == theme) {
      return darkOrLight.lightTheme;
    }
    return getThemeFromString(jsonDecode(theme));
  }

  static darkOrLight getThemeFromString(String themeString) {
    for (darkOrLight theme in darkOrLight.values) {
      if (theme.toString() == themeString) {
        return theme;
      }
    }
    return null;
  }
}
