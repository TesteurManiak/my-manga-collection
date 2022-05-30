import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/manga_repository_impl.dart';
import '../../../domain/entities/manga.dart';
import '../../../domain/entities/result.dart';
import '../../../domain/repositories/manga_repository.dart';

part 'manga_state.dart';

class MangaController extends StateNotifier<MangaState> {
  final List<Manga>? favoriteMangas;
  final MangaRepository _mangaRepository;

  MangaController({
    required MangaRepository mangaRepository,
    required Manga selectedManga,
    required this.favoriteMangas,
  })  : _mangaRepository = mangaRepository,
        super(
          MangaState(
            isFavorite: favoriteMangas?.contains(selectedManga) ?? false,
            manga: selectedManga,
          ),
        );

  Future<void> addToFavorite() =>
      _mangaRepository.addMangaToFavorite(state.manga);

  Future<void> removeFromFavorite() =>
      _mangaRepository.removeMangaFromFavorite(state.manga);

  Future<void> updateManga(Manga manga) async {
    state = state.copyWith(isLoading: true);
    final result = await _mangaRepository.editManga(manga);
    if (mounted) {
      state = state.copyWith(
        isLoading: false,
        hasError: result.type == ResultType.error,
      );
    }
  }
}

final mangaControllerProvider = StateNotifierProvider.autoDispose
    .family<MangaController, MangaState, String>((ref, id) {
  final repository = ref.watch(mangaRepositoryProvider);
  final favoriteMangas = ref.watch(favoriteChangeProvider).value;

  ref.onDispose(repository.dispose);

  return MangaController(
    mangaRepository: repository,
    selectedManga: repository.getFavorites().firstWhere((e) => e.id == id),
    favoriteMangas: favoriteMangas,
  );
});
