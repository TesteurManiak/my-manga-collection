import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/manga_repository_impl.dart';
import '../../../domain/entities/manga.dart';
import '../common/async_value_widget.dart';
import '../common/manga_list.dart';

class CollectionView extends ConsumerStatefulWidget {
  const CollectionView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CollectionViewState();
}

class _CollectionViewState extends ConsumerState<CollectionView>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('collectionView.title')),
        actions: [
          IconButton(
            onPressed: _searchPressed,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final value = ref.watch(favoriteChangeProvider);
          return AsyncValueWidget<List<Manga>>(
            value: value,
            data: (data) {
              if (data.isEmpty) {
                return Center(child: Text(tr('collectionView.emptyList')));
              }
              return MangaList(data);
            },
          );
        },
      ),
    );
  }

  void _searchPressed() {}

  @override
  bool get wantKeepAlive => true;
}
