part of 'manga_controller.dart';

@immutable
class MangaState extends Equatable {
  final bool isLoading;
  final bool hasError;
  final bool isFavorite;
  final Manga manga;

  const MangaState({
    this.isLoading = false,
    this.hasError = false,
    required this.isFavorite,
    required this.manga,
  });

  @override
  List<Object?> get props => [
        isLoading,
        hasError,
        isFavorite,
        manga,
      ];

  MangaState copyWith({
    bool? isLoading,
    bool? hasError,
    bool? isFavorite,
    Manga? manga,
  }) {
    return MangaState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      isFavorite: isFavorite ?? this.isFavorite,
      manga: manga ?? this.manga,
    );
  }
}
