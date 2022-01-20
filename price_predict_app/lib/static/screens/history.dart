import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_predict_app/dynamic/API/history_repo.dart';
import 'package:price_predict_app/dynamic/bloc/history/history_bloc.dart';
import 'package:price_predict_app/dynamic/firebase/auth_repository.dart';
import 'package:price_predict_app/static/screens/loader.dart';
import 'package:price_predict_app/static/widgets/buttons/custom_back_button.dart';
import 'package:price_predict_app/static/widgets/cards/custom_history_card.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  HistoryRepository historyRepository = HistoryRepository();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //HEIGHT-WIDTH
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    //THEME
    var theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topCenter,
                      colors: [theme.primaryColorDark, theme.primaryColor])),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomBackButton(),
                      Text("History", style: theme.textTheme.headline1),
                      SizedBox(
                        width: width * 0.1,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  BlocConsumer<HistoryBloc, HistoryState>(
                    listener: (context, state) {
                      if (state is HistoryFailureState) {
                        return ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.msg),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is HistoryLoadingState) {
                        return Column(
                          children: [
                            SizedBox(
                              height: height / 3,
                            ),
                            Loader(
                              text: '',
                            ),
                            SizedBox(
                              height: height / 2,
                            ),
                          ],
                        );
                      } else if (state is HistoryLoadedState) {
                        if (state.historyModel.length == 0) {
                          return Column(
                            children: [
                              SizedBox(
                                height: height / 3,
                              ),
                              Text(
                                "No history yet",
                                style: TextStyle(color: Colors.red),
                              ),
                              SizedBox(
                                height: height / 2,
                              ),
                            ],
                          );
                        } else {
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: state.historyModel.length,
                              itemBuilder: (context, i) {
                                return CustomHistoryCard(
                                  history: state.historyModel[i],
                                );
                              });
                        }
                      }

                      return Container();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
