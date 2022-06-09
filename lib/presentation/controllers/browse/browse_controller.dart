import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/manga_repository_impl.dart';
import '../../../domain/entities/manga.dart';
import '../../../domain/entities/result.dart';

part 'browse_state.dart';

class BrowseController extends StateNotifier<BrowseState> {
  final AutoDisposeRef _ref;

  BrowseController(this._ref) : super(const BrowseState()) {
    _ref.listen<AsyncValue<List<Manga>>>(resultsChangeProvider,
        (previous, next) {
      final mangas = next.asData?.value;
      if (mangas != null) {
        state = state.copyWith(mangas: mangas);
      }
    });
  }

  void searchMangas(String title) async {
    if (title.isEmpty) return;
    state = state.copyWith(isLoading: true);
    final repository = _ref.read(mangaRepositoryProvider);
    final result = await repository.searchMangas(title);
    state = state.copyWith(
      isLoading: false,
      hasError: result.type == ResultType.error,
      mangas: result.value,
    );
  }
}

final browseControllerProvider =
    StateNotifierProvider.autoDispose<BrowseController, BrowseState>(
  BrowseController.new,
);
