import 'package:flutter/material.dart';

class CustomProfileCard extends StatelessWidget {
  String name;
  Function onPressed;

  CustomProfileCard({this.name, this.onPressed});
  @override
  Widget build(BuildContext context) {
    //HEIGHT-WIDTH
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    //THEME
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          height: height * 0.09,
          width: width * 0.8,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: theme.textTheme.headline3,
                ),
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 30,
                  color: theme.scaffoldBackgroundColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
