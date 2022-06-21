import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../router.dart';
import '../../../controllers/home/home_controller.dart';
import '../../../style/colors.dart';

class AnimatedBottomBar extends ConsumerWidget {
  final int currentPage;

  const AnimatedBottomBar({
    Key? key,
    required this.currentPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hideBottomBar = ref.watch(homeControllerProvider);
    final colors = Theme.of(context).extension<AppColors>();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: hideBottomBar ? 0 : kBottomNavigationBarHeight,
      child: Wrap(
        children: [
          BottomNavigationBar(
            currentIndex: currentPage,
            fixedColor: colors?.fixedBottomNavigationBar,
            // onTap: _pageController.jumpToPage,
            onTap: (index) => context.goNamed(
              AppRoute.home.name,
              params: {'index': index.toString()},
            ),
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
        ],
      ),
    );
  }
}
