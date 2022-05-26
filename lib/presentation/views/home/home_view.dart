import 'package:flutter/material.dart';

import '../../../core/extensions/string_extensions.dart';
import '../../style/colors.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColors>();
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        fixedColor: colors?.fixedBottomNavigationBar,
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
          )
        ],
      ),
    );
  }
}
