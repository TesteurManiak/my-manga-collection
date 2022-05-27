import 'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialIndex = 1;

class HomeController extends StateNotifier<int> {
  HomeController() : super(kInitialIndex);

  void goToIndex(int index) => state = index;
}

final homeControllerProvider =
    StateNotifierProvider.autoDispose<HomeController, int>((_) {
  return HomeController();
});
