part of 'manga_controller.dart';

class MangaState extends Equatable {
  final bool isLoading;
  final bool hasError;
  final bool isFavorite;

  const MangaState({
    this.isLoading = false,
    this.hasError = false,
    required this.isFavorite,
  });

  @override
  List<Object?> get props => [
        isLoading,
        hasError,
        isFavorite,
      ];

  MangaState copyWith({
    bool? isLoading,
    bool? hasError,
    bool? isFavorite,
  }) {
    return MangaState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
