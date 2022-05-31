import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/extensions/string_extensions.dart';
import '../../../controllers/manga/manga_controller.dart';

class ExportButton extends ConsumerWidget {
  const ExportButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(mangaControllerProvider.notifier);
    return ListTile(
      title: Text('Export Collection'.hardcoded),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: controller.exportCollection,
    );
  }
}
