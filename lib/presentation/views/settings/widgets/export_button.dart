import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../controllers/settings/settings_controller.dart';

class ExportButton extends ConsumerWidget {
  const ExportButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(settingsControllerProvider);
    return ListTile(
      title: Text('Export Collection'.hardcoded),
      trailing: const Icon(Icons.download),
      onTap: () {
        controller.exportCollection().then((result) {
          context.showSnackBar(
            SnackBar(content: Text(result.anyValue.toString())),
          );
        });
      },
    );
  }
}
