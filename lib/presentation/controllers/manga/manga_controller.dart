import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/manga_repository_impl.dart';
import '../../../domain/entities/manga.dart';
import '../../../domain/repositories/manga_repository.dart';

part 'manga_state.dart';

class MangaController extends StateNotifier<MangaState> {
  final Manga selectedManga;
  final List<Manga>? favoriteMangas;
  final MangaRepository _mangaRepository;

  MangaController({
    required MangaRepository mangaRepository,
    required this.selectedManga,
    required this.favoriteMangas,
  })  : _mangaRepository = mangaRepository,
        super(
          MangaState(
            isFavorite: favoriteMangas?.contains(selectedManga) ?? false,
          ),
        );

  Future<void> addToFavorite() =>
      _mangaRepository.addMangaToFavorite(selectedManga);

  Future<void> removeFromFavorite() =>
      _mangaRepository.removeMangaFromFavorite(selectedManga);
}

final mangaControllerProvider = StateNotifierProvider.autoDispose
    .family<MangaController, MangaState, Manga>((ref, manga) {
  final repository = ref.watch(mangaRepositoryProvider);
  final favoriteMangas = ref.watch(favoriteChangeProvider).value;

  return MangaController(
    mangaRepository: repository,
    selectedManga: manga,
    favoriteMangas: favoriteMangas,
  );
});
