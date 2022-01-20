import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_predict_app/dynamic/bloc/history/history_bloc.dart';
import 'package:price_predict_app/dynamic/models/history_model.dart';

class CustomHistoryCard extends StatelessWidget {
  HistoryModel history;

  CustomHistoryCard({
    this.history,
  });
  @override
  Widget build(BuildContext context) {
    //HEIGHT-WIDTH
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    //THEME
    var theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: theme.primaryColorLight,
          ),
          // height: height * 0.3,
          // width: width * 0.5,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  history.brand,
                  style: theme.textTheme.bodyText2,
                ),
                Text(
                  history.model,
                  style: theme.textTheme.headline3,
                ),
                Divider(
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          history.city,
                          style: theme.textTheme.headline3,
                        ),
                        Text(
                          history.year,
                          style: theme.textTheme.headline3,
                        ),
                        Text(
                          "${history.cc} cc",
                          style: theme.textTheme.headline3,
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${history.km} km",
                          style: theme.textTheme.headline3,
                        ),
                        Text(
                          history.fuel_type,
                          style: theme.textTheme.headline3,
                        ),
                        Text(
                          history.mode,
                          style: theme.textTheme.headline3,
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                ),
                Center(
                  child: Text(
                    "Predicted price: ${history.price}",
                    style: theme.textTheme.bodyText2,
                  ),
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Center(
                    child: Container(
                  width: width,
                  child: RaisedButton(
                      onPressed: () {
                        BlocProvider.of<HistoryBloc>(context)
                            .add(DeleteHistoryEvent(history.id));
                        return ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Deleted'),
                          ),
                        );
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: theme.primaryColorLight,
                      child: Text(
                        "Delete",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                            fontFamily: 'CenturyGothic'),
                      )),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
