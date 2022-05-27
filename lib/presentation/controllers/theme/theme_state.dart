part of 'theme_controller.dart';

const fallbackThemeMode = ThemeMode.system;

@immutable
class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({this.themeMode = fallbackThemeMode});

  @override
  List<Object?> get props => [themeMode];

  ThemeState copyWith({
    ThemeMode? themeMode,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
