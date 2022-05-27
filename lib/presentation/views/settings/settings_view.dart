import 'package:flutter/material.dart';

import '../../../core/extensions/string_extensions.dart';
import 'widgets/theme_switcher.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'.hardcoded),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ThemeSwitcher(),
        ],
      ),
    );
  }
}
