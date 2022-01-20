import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_predict_app/dynamic/API/user_repo.dart';
import 'package:price_predict_app/dynamic/bloc/feature/feature_bloc.dart';
import 'package:price_predict_app/dynamic/bloc/history/history_bloc.dart';
import 'package:price_predict_app/dynamic/bloc/theme/theme_bloc.dart';
import 'package:price_predict_app/dynamic/bloc/user/user_bloc.dart';
import 'package:price_predict_app/dynamic/firebase/auth_state/collector.dart';
import 'package:price_predict_app/static/utils/theme_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await ThemePreferences.init();
  await UserRepository().startServer();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeBloc()),
          BlocProvider(create: (context) => UserBloc()),
          BlocProvider(create: (context) => HistoryBloc()),
          BlocProvider(create: (context) => FeatureBloc()),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
          if (state is ThemeInitial) {
            return MaterialApp(
              title: 'Price predictor',
              debugShowCheckedModeBanner: false,
              home: Collector(),
              theme: state.themeData,
            );
          } else {
            return Container();
          }
        }));
  }
}
