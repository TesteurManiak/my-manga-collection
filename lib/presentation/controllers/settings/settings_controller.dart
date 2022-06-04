import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/manga_repository_impl.dart';
import '../../../domain/entities/result.dart';
import '../../../domain/repositories/manga_repository.dart';

class SettingsController {
  final MangaRepository _mangaRepository;

  SettingsController({required MangaRepository mangaRepository})
      : _mangaRepository = mangaRepository;

  Future<String> exportCollection() async {
    final result = await _mangaRepository.exportCollection();
    if (result.type == ResultType.error) {
      return result.requireError.toString();
    } else {
      return tr('settingsView.savedTo', args: [result.requireValue]);
    }
  }

  Future<Result<bool, Object>> importCollection() =>
      _mangaRepository.importCollection();
}

final settingsControllerProvider = Provider<SettingsController>((ref) {
  final repository = ref.watch(mangaRepositoryProvider);
  return SettingsController(mangaRepository: repository);
});
