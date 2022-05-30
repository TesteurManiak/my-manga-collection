import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../style/colors.dart';
import '../browse/browse_view.dart';
import '../collection/collection_view.dart';
import '../settings/settings_view.dart';

const _kInitialPage = 1;

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final _pageController = PageController(initialPage: _kInitialPage);

  int _currentPage = _kInitialPage;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(_onPageChanged);
  }

  @override
  void dispose() {
    _pageController
      ..removeListener(_onPageChanged)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        fixedColor: colors?.fixedBottomNavigationBar,
        onTap: _pageController.jumpToPage,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.add),
            label: tr('homeView.item1'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.book),
            label: tr('homeView.item2'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: tr('homeView.item3'),
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: const [
          BrowseView(),
          CollectionView(),
          SettingsView(),
        ],
      ),
    );
  }

  void _onPageChanged() =>
      setState(() => _currentPage = _pageController.page!.toInt());
}
