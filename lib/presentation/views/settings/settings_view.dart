import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'widgets/export_button.dart';
import 'widgets/locale_dropdown.dart';
import 'widgets/theme_switcher.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('settingsView.title')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ThemeSwitcher(),
          LocaleDropdown(),
          ExportButton(),
        ],
      ),
    );
  }
}
