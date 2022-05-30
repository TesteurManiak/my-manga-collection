import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      body: Container(),
    );
  }

  void _searchPressed() {}

  @override
  bool get wantKeepAlive => true;
}
