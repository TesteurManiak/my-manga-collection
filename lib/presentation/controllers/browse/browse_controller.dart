import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/manga_repository_impl.dart';
import '../../../domain/entities/manga.dart';
import '../../../domain/entities/result.dart';
import '../../../domain/repositories/manga_repository.dart';

part 'browse_state.dart';

class BrowseController extends StateNotifier<BrowseState> {
  final MangaRepository _mangaRepository;

  BrowseController({required MangaRepository mangaRepository})
      : _mangaRepository = mangaRepository,
        super(const BrowseState());

  void searchMangas(String title) async {
    state = state.copyWith(isLoading: true);
    final result = await _mangaRepository.searchMangas(title);
    state = state.copyWith(
      isLoading: false,
      hasError: result.type == ResultType.error,
      mangas: result.value,
    );
  }
}

final browseControllerProvider =
    StateNotifierProvider.autoDispose<BrowseController, BrowseState>((ref) {
  final repository = ref.watch(mangaRepositoryProvider);
  return BrowseController(mangaRepository: repository);
});
