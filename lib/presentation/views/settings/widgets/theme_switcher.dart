import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/string_extensions.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    return SwitchListTile(
      title: Text('Dark Mode'.hardcoded),
      value: isDark,
      onChanged: (_) => DynamicTheme.of(context).toggleThemeMode(),
    );
  }
}
