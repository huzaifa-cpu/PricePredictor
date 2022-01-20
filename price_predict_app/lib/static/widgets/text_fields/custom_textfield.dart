import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  String label;
  String initialValue;
  TextInputType type;
  List<TextInputFormatter> inputFormatter;
  Function validator;
  ValueChanged onChanged;

  CustomTextField({
    this.initialValue,
    this.inputFormatter,
    this.onChanged,
    this.type,
    this.validator,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    //THEME
    var theme = Theme.of(context);
    return TextFormField(
      style: theme.textTheme.headline3,
      validator: validator,
      initialValue: initialValue,
      inputFormatters: inputFormatter,
      onChanged: onChanged,
      keyboardType: type,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        labelText: label,
        labelStyle: theme.textTheme.headline5,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: theme.scaffoldBackgroundColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: theme.scaffoldBackgroundColor),
        ),
      ),
    );
  }
}
