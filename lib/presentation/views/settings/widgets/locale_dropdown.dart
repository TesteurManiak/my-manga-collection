import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/extensions/locale_extensions.dart';

class LocaleDropdown extends StatelessWidget {
  const LocaleDropdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(tr('settingsView.language')),
      trailing: DropdownButton<Locale>(
        value: context.locale,
        items: context.supportedLocales
            .map<DropdownMenuItem<Locale>>(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(e.translatedLocaleName()),
              ),
            )
            .toList(),
        onChanged: (Locale? locale) {
          if (locale != null) {
            context.setLocale(locale);
          }
        },
      ),
    );
  }
}
