import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/string_extensions.dart';
import '../../../controllers/theme/theme_controller.dart';

class ThemeSwitcher extends ConsumerWidget {
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final controller = ref.read(themeControllerProvider.notifier);
    return SwitchListTile(
      title: Text('Dark Mode'.hardcoded),
      value: isDark,
      onChanged: (_) => controller.switchThemeMode(brightness),
    );
  }
}
