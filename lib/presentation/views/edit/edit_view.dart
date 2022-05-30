import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/string_extensions.dart';
import '../../../data/repositories/manga_repository_impl.dart';
import '../../../domain/entities/manga.dart';
import '../common/async_value_widget.dart';

class EditView extends ConsumerWidget {
  final String id;

  const EditView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(favoriteChangeProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Edit'.hardcoded)),
      body: AsyncValueWidget<List<Manga>>(
        value: value,
        data: (data) {
          final manga = data.firstWhereOrNull((e) => e.id == id);
          if (manga == null) {
            return const Text('Manga not found');
          }
          return Text('Editing ${manga.title}');
        },
      ),
    );
  }
}
