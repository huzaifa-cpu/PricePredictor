import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_predict_app/dynamic/bloc/user/user_bloc.dart';
import 'package:price_predict_app/dynamic/models/auth_model.dart';
import 'package:price_predict_app/static/screens/category.dart';
import 'package:price_predict_app/static/screens/login.dart';
import 'package:provider/provider.dart';

class Decider extends StatefulWidget {
  @override
  _DeciderState createState() => _DeciderState();
}

class _DeciderState extends State<Decider> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UserBloc>(context).add(UserGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthModel>(context);

    if (user == null) {
      return Login();
    } else {
      return Category();
    }
  }
}
