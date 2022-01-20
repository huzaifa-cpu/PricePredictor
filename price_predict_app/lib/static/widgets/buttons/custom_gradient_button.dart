import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  String name;
  Function onPressed;
  String image;
  @required
  bool withImage;

  CustomGradientButton({this.name, this.onPressed, this.withImage, this.image});
  @override
  Widget build(BuildContext context) {
    //HEIGHT-WIDTH
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    //THEME
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: withImage
            ? Container(
                width: width * 0.8,
                height: height * 0.07,
                child: Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      image,
                      width: width * 0.1,
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'CenturyGothic',
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      Colors.blue,
                      Color(0xFF8CD7AE),
                    ])),
              )
            : Container(
                width: width * 0.8,
                height: height * 0.07,
                child: Center(
                    child: Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 15),
                )),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(colors: [
                      Colors.blue,
                      Color(0xFF8CD7AE),
                    ])),
              ),
      ),
    );
  }
}
