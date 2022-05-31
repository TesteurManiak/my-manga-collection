part of 'manga_controller.dart';

@immutable
class MangaState extends Equatable {
  final bool isLoading;
  final bool hasError;

  const MangaState({
    this.isLoading = false,
    this.hasError = false,
  });

  @override
  List<Object?> get props => [
        isLoading,
        hasError,
      ];

  MangaState copyWith({
    bool? isLoading,
    bool? hasError,
  }) {
    return MangaState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
    );
  }
}
