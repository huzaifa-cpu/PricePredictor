import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  String value;
  Function onChanged;
  List<String> list;
  String label;
  CustomDropDown({this.value, this.onChanged, this.list, this.label});
  @override
  Widget build(BuildContext context) {
    //THEME
    var theme = Theme.of(context);
    return Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
                fillColor: theme.primaryColorLight,
                focusColor: theme.primaryColorLight,
                border: InputBorder.none,
                labelText: label,
                labelStyle: theme.textTheme.headline5),
            value: value,
            icon: Icon(
              Icons.arrow_drop_down,
              color: theme.scaffoldBackgroundColor,
            ),
            iconSize: 30,
            elevation: 16,
            dropdownColor: theme.primaryColorLight,
            style: theme.textTheme.headline3,
            onChanged: onChanged,
            items: list.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: theme.textTheme.headline3,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
