import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/string_extensions.dart';
import '../../controllers/home/home_controller.dart';
import '../../style/colors.dart';
import '../browse/browse_view.dart';
import '../collection/collection_view.dart';
import '../settings/settings_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final _pageController = PageController(initialPage: kInitialIndex);
  late final HomeController _homeController;

  @override
  void initState() {
    super.initState();
    _homeController = ref.read(homeControllerProvider.notifier);
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
    final currentIndex = ref.watch(homeControllerProvider);
    final colors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        fixedColor: colors?.fixedBottomNavigationBar,
        onTap: _pageController.jumpToPage,
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
      _homeController.goToIndex(_pageController.page!.toInt());
}
