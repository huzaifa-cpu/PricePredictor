part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {
  const ThemeEvent();
}

class ChangeEvent extends ThemeEvent {
  final darkOrLight myTheme;
  const ChangeEvent({this.myTheme});
}
