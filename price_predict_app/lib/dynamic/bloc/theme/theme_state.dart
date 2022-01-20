part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {
  const ThemeState();
}

class ThemeInitial extends ThemeState {
  final ThemeData themeData;
  const ThemeInitial({this.themeData});
}
