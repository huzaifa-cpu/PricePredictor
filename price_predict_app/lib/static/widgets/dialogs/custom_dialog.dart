import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  String title;
  Function onOkPressed;
  CustomDialog({this.title, this.onOkPressed});
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
      title: Text(title, style: theme.textTheme.bodyText2),
      backgroundColor: theme.primaryColorLight,
      actions: [
        RaisedButton(
            elevation: 0.0,
            color: theme.primaryColorLight,
            child: Text("Ok", style: theme.textTheme.bodyText2),
            onPressed: onOkPressed),
        RaisedButton(
            elevation: 0.0,
            color: theme.primaryColorLight,
            child: Text("Cancel", style: theme.textTheme.bodyText2),
            onPressed: () {
              Navigator.pop(context);
            })
      ],
    );
  }
}
