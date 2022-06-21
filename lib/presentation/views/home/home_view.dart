import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../browse/browse_view.dart';
import '../collection/collection_view.dart';
import '../settings/settings_view.dart';
import 'widgets/animated_bottom_bar.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: AnimatedBottomBar(currentPage: _currentPage),
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
