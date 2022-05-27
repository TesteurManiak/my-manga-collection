import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/string_extensions.dart';
import '../../../router.dart';
import '../../style/colors.dart';
import '../collection/collection_view.dart';
import '../settings/settings_view.dart';

class HomeView extends StatefulWidget {
  final int index;

  const HomeView({Key? key, required this.index})
      : assert(index >= 0),
        super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _subViews = <Widget>[
    const Scaffold(body: Center(child: Text('0'))),
    const CollectionView(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.index,
        fixedColor: colors?.fixedBottomNavigationBar,
        onTap: (index) =>
            context.goNamed(AppRoute.home.name, params: {'index': '$index'}),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.add),
            label: "Add Manga".hardcoded,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.book),
            label: "Collection".hardcoded,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: "Settings".hardcoded,
          ),
        ],
      ),
      body: _subViews[widget.index],
    );
  }
}
