import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/string_extensions.dart';
import '../../../controllers/settings/settings_controller.dart';

class ImportButton extends ConsumerWidget {
  const ImportButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(settingsControllerProvider);
    return ListTile(
      title: Text('Import Collection'.hardcoded),
      trailing: const Icon(Icons.file_upload),
      onTap: controller.importCollection,
    );
  }
}
