import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'dummy_manga_grid.dart';
import 'responsive_layout.dart';

class ShimmerMangaList extends StatelessWidget {
  const ShimmerMangaList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.transparent,
      highlightColor: Colors.grey[100]!,
      period: const Duration(milliseconds: 600),
      child: ResponsiveLayout(
        mobile: (_, __) =>
            const DummyMangaGrid(itemCount: 20, crossAxisCount: 2),
        tablet: (_, __) =>
            const DummyMangaGrid(itemCount: 25, crossAxisCount: 5),
        desktop: (_, __) => const DummyMangaGrid(itemCount: 30),
      ),
    );
  }
}
