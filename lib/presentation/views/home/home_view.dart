import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../router.dart';
import '../../style/colors.dart';
import '../browse/browse_view.dart';
import '../collection/collection_view.dart';
import '../settings/settings_view.dart';

class HomeView extends ConsumerStatefulWidget {
  final int index;

  const HomeView({Key? key, required this.index}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late final _pageController = PageController(initialPage: widget.index);

  late int _currentPage = widget.index;

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
  void didUpdateWidget(covariant HomeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    _pageController.jumpToPage(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        fixedColor: colors?.fixedBottomNavigationBar,
        // onTap: _pageController.jumpToPage,
        onTap: (index) => context
            .goNamed(AppRoute.home.name, params: {'index': index.toString()}),
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
        physics: const NeverScrollableScrollPhysics(),
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
