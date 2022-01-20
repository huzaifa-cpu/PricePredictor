import 'package:flutter/material.dart';
import 'package:price_predict_app/static/screens/predict.dart';

class CategoryCard extends StatelessWidget {
  String brandName;
  String models;
  Function onPressed;

  CategoryCard({this.brandName, this.models, this.onPressed});
  @override
  Widget build(BuildContext context) {
    //HEIGHT-WIDTH
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    //THEME
    var theme = Theme.of(context);
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Predict(
                      brandName: brandName,
                    )));
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          height: height * 0.15,
          width: width * 0.8,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      brandName,
                      style: theme.textTheme.bodyText1,
                    ),
                    Text(
                      "$models models",
                      style: theme.textTheme.bodyText2,
                    )
                  ],
                ),
                Spacer(),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 65,
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
