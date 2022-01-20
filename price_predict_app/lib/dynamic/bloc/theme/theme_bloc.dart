import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:price_predict_app/static/utils/app_themes.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(
            ThemeInitial(themeData: AppThemes.themes[darkOrLight.lightTheme]));

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if (event is ChangeEvent) {
      yield ThemeInitial(themeData: AppThemes.themes[event.myTheme]);
    }
  }
}
