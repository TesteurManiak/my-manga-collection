import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../controllers/settings/settings_controller.dart';

class ExportButton extends ConsumerWidget {
  const ExportButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(settingsControllerProvider);
    return ListTile(
      title: Text(tr('settingsView.export')),
      trailing: const Icon(Icons.download),
      onTap: () {
        controller.exportCollection().then((msg) {
          context.showSnackBar(
            SnackBar(content: Text(msg)),
          );
        });
      },
    );
  }
}
