import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/manga_repository_impl.dart';
import '../../../domain/entities/result.dart';
import '../../../domain/repositories/manga_repository.dart';

class SettingsController {
  final MangaRepository _mangaRepository;

  SettingsController({required MangaRepository mangaRepository})
      : _mangaRepository = mangaRepository;

  Future<Result<String, Object>> exportCollection() =>
      _mangaRepository.exportCollection();
}

final settingsControllerProvider = Provider<SettingsController>((ref) {
  final repository = ref.watch(mangaRepositoryProvider);
  return SettingsController(mangaRepository: repository);
});
