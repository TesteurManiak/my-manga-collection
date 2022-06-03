import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/string_extensions.dart';
import '../../../../domain/entities/result.dart';
import '../../../controllers/settings/settings_controller.dart';
import '../../common/snackbars.dart';

class ImportButton extends ConsumerWidget {
  const ImportButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(settingsControllerProvider);
    return ListTile(
      title: Text('Import Collection'.hardcoded),
      trailing: const Icon(Icons.file_upload),
      onTap: () => _onTap(controller, context),
    );
  }

  void _onTap(SettingsController controller, BuildContext context) {
    controller.importCollection().then((result) {
      if (result.type == ResultType.error) {
        context.showSnackBar(
          ErrorSnackBar(
            'An error occured while importing the collection.'.hardcoded,
          ),
        );
      } else if (result.requireValue) {
        context.showSnackBar(
          SuccessSnackBar(
            'Your collection has been imported successfully.'.hardcoded,
          ),
        );
      }
    });
  }
}
