import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/manga_repository_impl.dart';
import '../../../domain/entities/manga.dart';
import '../common/async_value_widget.dart';
import 'widgets/manga_edition_form.dart';
import 'widgets/manga_not_found.dart';

class EditView extends ConsumerWidget {
  final String id;

  const EditView({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(favoriteChangeProvider);
    return AsyncValueWidget<List<Manga>>(
      value: value,
      error: (_, __) => MangaNotFound(id: id),
      data: (data) {
        final manga = data.firstWhereOrNull((e) => e.id == id);
        if (manga == null) return MangaNotFound(id: id);
        return MangaEditionForm(manga: manga);
      },
    );
  }
}
