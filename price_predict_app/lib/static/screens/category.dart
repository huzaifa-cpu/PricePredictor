import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_predict_app/dynamic/bloc/history/history_bloc.dart';
import 'package:price_predict_app/dynamic/bloc/theme/theme_bloc.dart';
import 'package:price_predict_app/dynamic/bloc/user/user_bloc.dart';
import 'package:price_predict_app/dynamic/firebase/auth_repository.dart';
import 'package:price_predict_app/static/screens/profile.dart';
import 'package:price_predict_app/static/utils/theme_preference.dart';
import 'package:price_predict_app/static/widgets/cards/category_card.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category>
    with SingleTickerProviderStateMixin {
  //ANIMATIONS
  Animation animation;
  AnimationController animationController;
  Animation animationText;
  AnimationController animationControllerText;
  AuthRepository authRepository = AuthRepository();

  @override
  void initState() {
    super.initState();
    _loadTheme();
    BlocProvider.of<UserBloc>(context).add(UserGetEvent());
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));
    animationController.forward();
  }

  _loadTheme() async {
    BlocProvider.of<ThemeBloc>(context)
        .add(ChangeEvent(myTheme: ThemePreferences.getTheme()));
  }

  @override
  Widget build(BuildContext context) {
    //HEIGHT-WIDTH
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    //THEME
    var theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: theme.primaryColorLight,
          foregroundColor: theme.scaffoldBackgroundColor,
          child: Icon(Icons.person),
          tooltip: "Profile",
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Profile()));
          }),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topCenter,
                    colors: [theme.primaryColorDark, theme.primaryColor])),
          ),
          SingleChildScrollView(
            child: AnimatedBuilder(
                animation: animationController,
                builder: (BuildContext context, Widget child) {
                  return Transform(
                    transform: Matrix4.translationValues(
                        animation.value * width, 0.0, 0.0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.08,
                        ),
                        Text(
                          "Select brand name",
                          style: theme.textTheme.headline1,
                        ),
                        SizedBox(
                          height: height * 0.1,
                        ),
                        CategoryCard(
                          brandName: 'Honda',
                          models: '70',
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        CategoryCard(
                          brandName: 'Toyota',
                          models: '50',
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        CategoryCard(
                          brandName: 'Suzuki',
                          models: '35',
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
