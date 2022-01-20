import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  String text;
  Loader({this.text});

  @override
  Widget build(BuildContext context) {
    //THEME
    var theme = Theme.of(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topCenter,
                  colors: [theme.primaryColorDark, theme.primaryColor])),
        ),
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SpinKitFadingCircle(
                  color: theme.scaffoldBackgroundColor,
                  size: 60,
                ),
              ),
              Text(text ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.0,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
