part of 'theme_cubit.dart';

enum AppTheme { light, dark }

class ThemeState extends Equatable {
  final AppTheme appTheme;

  const ThemeState(this.appTheme);
  factory ThemeState.initial() {
    return const ThemeState(AppTheme.light);
  }
  @override
  List<Object> get props => [appTheme];

  ThemeState copyWith({AppTheme? appTheme}) {
    return ThemeState(appTheme ?? this.appTheme);
  }
}
