import 'package:flutter/material.dart';

import 'dummy_manga_cell.dart';

class DummyMangaGrid extends StatelessWidget {
  final int crossAxisCount;
  final int itemCount;

  const DummyMangaGrid({
    Key? key,
    this.crossAxisCount = 7,
    required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.75,
      ),
      itemCount: itemCount,
      itemBuilder: (_, __) => const DummyMangaCell(),
    );
  }
}
