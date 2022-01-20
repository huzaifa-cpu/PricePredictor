import 'package:flutter/material.dart';

class CustomPredictionDialog extends StatelessWidget {
  String price;
  Function onOkPressed;
  Function onCancelPressed;
  CustomPredictionDialog({this.price, this.onOkPressed, this.onCancelPressed});
  @override
  Widget build(BuildContext context) {
    //THEMES
    var theme = Theme.of(context);
    //height - width
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Text("Predicted Price:", style: theme.textTheme.headline3),
      contentPadding: EdgeInsets.all(0),
      content: Container(
        width: width * 0.3,
        height: height * 0.08,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: theme.primaryColorLight,
        ),
        child: Text(price, style: theme.textTheme.bodyText1),
      ),
      backgroundColor: theme.primaryColorLight,
      actions: [
        RaisedButton(
            elevation: 0.0,
            color: theme.primaryColorLight,
            child: Text("Save in history", style: theme.textTheme.bodyText2),
            onPressed: onOkPressed),
        RaisedButton(
            elevation: 0.0,
            color: theme.primaryColorLight,
            child: Text("Cancel", style: theme.textTheme.bodyText2),
            onPressed: onCancelPressed)
      ],
    );
  }
}
