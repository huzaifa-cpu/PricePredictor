import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:price_predict_app/dynamic/API/user_repo.dart';
import 'package:price_predict_app/dynamic/bloc/user/user_bloc.dart';
import 'package:price_predict_app/dynamic/firebase/auth_repository.dart';
import 'package:price_predict_app/dynamic/models/user_model.dart';
import 'package:price_predict_app/static/screens/loader.dart';
import 'package:price_predict_app/static/widgets/buttons/custom_gradient_button.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthRepository authRepository = AuthRepository();
  final UserRepository userRepository = UserRepository();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    //HEIGHT-WIDTH
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    //THEME
    var theme = Theme.of(context);
    return loading
        ? Loader()
        : Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/car_bg.jpeg"),
                          fit: BoxFit.fill)),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
                  child: Container(color: Colors.black.withOpacity(0.3)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'USED',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 100,
                          fontFamily: 'CenturyGothic',
                          fontWeight: FontWeight.w900),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Car',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 53,
                              fontFamily: 'CenturyGothic',
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(
                          'Price',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 53,
                              fontFamily: 'CenturyGothic',
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      'Predictor',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50,
                          fontFamily: 'CenturyGothic',
                          fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: height * 0.2,
                    ),
                    CustomGradientButton(
                      name: "Sign in with Google",
                      withImage: true,
                      image: 'images/google.png',
                      onPressed: () async {
                        // Loading
                        setState(() {
                          loading = true;
                        });
                        //FIREBASE
                        bool value = await signInGoogle();
                        if (value) {
                          setState(() {
                            loading = false;
                          });
                        } else {
                          setState(() {
                            loading = false;
                          });
                          Fluttertoast.showToast(
                              msg: "Can't login",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.grey[500],
                              // textColor: theme.primaryColor,
                              fontSize: 14);
                        }
                      },
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                  ],
                )
              ],
            ),
          );
  }

  // FIREBASE LOGIN
  Future<bool> signInGoogle() async {
    bool result = false;
    await authRepository.signInWithGoogle().then((User user) async {
      if (user != null) {
        UserModel userModel = UserModel(
          id: user.uid,
          email: user.email,
          name: user.email.split('@')[0],
          photo: 'no photo',
        );
        await userRepository.insertUser(userModel);
        BlocProvider.of<UserBloc>(context).add(UserGetEvent());
        setState(() {
          result = true;
        });
      }
    });
    return result;
  }
}
