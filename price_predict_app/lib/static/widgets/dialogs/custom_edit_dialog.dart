import 'package:flutter/material.dart';
import 'package:price_predict_app/static/widgets/text_fields/custom_textfield.dart';

class CustomEditDialog extends StatelessWidget {
  Function onOkPressed;
  ValueChanged valueChanged;
  String initialValue;
  CustomEditDialog({this.onOkPressed, this.valueChanged, this.initialValue});
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
      title: Text("New name", style: theme.textTheme.bodyText2),
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      content: Container(
        width: width * 0.3,
        height: height * 0.1,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: theme.primaryColorLight,
        ),
        child: CustomTextField(
          initialValue: initialValue,
          onChanged: valueChanged,
        ),
      ),
      backgroundColor: theme.primaryColorLight,
      actions: [
        RaisedButton(
            elevation: 0.0,
            color: theme.primaryColorLight,
            child: Text("Edit", style: theme.textTheme.bodyText2),
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
