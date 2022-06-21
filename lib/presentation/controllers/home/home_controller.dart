import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeController extends StateNotifier<bool> {
  HomeController() : super(false);

  bool get hasScrolledDown => state;

  void onScrolled(ScrollDirection scrollDirection) {
    if (scrollDirection == ScrollDirection.reverse) {
      state = true;
    } else if (scrollDirection == ScrollDirection.forward) {
      state = false;
    }
  }
}

final homeControllerProvider =
    StateNotifierProvider.autoDispose<HomeController, bool>((_) {
  return HomeController();
});
