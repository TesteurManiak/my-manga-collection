import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/string_extensions.dart';

class CollectionView extends ConsumerStatefulWidget {
  const CollectionView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CollectionViewState();
}

class _CollectionViewState extends ConsumerState<CollectionView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collection'.hardcoded),
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
}
