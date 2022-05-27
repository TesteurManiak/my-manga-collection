part of 'browse_controller.dart';

@immutable
class BrowseState extends Equatable {
  final bool isLoading;
  final bool hasError;
  final List<Manga> mangas;

  const BrowseState({
    this.isLoading = false,
    this.hasError = false,
    this.mangas = const [],
  });

  @override
  List<Object?> get props => [
        isLoading,
        hasError,
        mangas,
      ];

  BrowseState copyWith({
    bool? isLoading,
    bool? hasError,
    List<Manga>? mangas,
  }) {
    return BrowseState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      mangas: mangas ?? this.mangas,
    );
  }
}
