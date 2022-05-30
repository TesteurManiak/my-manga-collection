import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    return SwitchListTile(
      title: Text(tr('settingsView.darkMode')),
      value: isDark,
      onChanged: (_) => DynamicTheme.of(context).toggleThemeMode(),
    );
  }
}
