import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_predict_app/dynamic/bloc/feature/feature_bloc.dart';
import 'package:price_predict_app/dynamic/bloc/history/history_bloc.dart';
import 'package:price_predict_app/dynamic/bloc/user/user_bloc.dart';
import 'package:price_predict_app/dynamic/firebase/auth_repository.dart';
import 'package:price_predict_app/dynamic/models/feature_model.dart';
import 'package:price_predict_app/dynamic/models/history_model.dart';
import 'package:price_predict_app/static/screens/loader.dart';
import 'package:price_predict_app/static/utils/car_models_data.dart';
import 'package:price_predict_app/static/widgets/buttons/custom_back_button.dart';
import 'package:price_predict_app/static/widgets/buttons/custom_gradient_button.dart';
import 'package:price_predict_app/static/widgets/dialogs/custom_prediction_dialog.dart';
import 'package:price_predict_app/static/widgets/text_fields/custom_dropdown.dart';

class Predict extends StatefulWidget {
  String brandName;
  Predict({this.brandName});
  @override
  _PredictState createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  String model = 'Select model';
  String city = 'Karachi';
  String fuelType = 'Petrol';
  String mode = 'Manual';
  String year = '2010';
  String cc = '1000';
  String km = '10000';

  CarModelsData data = CarModelsData();
  AuthRepository authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    //HEIGHT-WIDTH
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    //THEME
    var theme = Theme.of(context);
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topCenter,
                    colors: [theme.primaryColorDark, theme.primaryColor])),
          ),
          SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: BlocConsumer<FeatureBloc, FeatureState>(
                  listener: (context, state) {
                    if (state is FeatureFailure) {
                      return ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.msg),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is FeatureLoading) {
                      return Loader(
                        text: "",
                      );
                    } else if (state is FeatureLoaded) {
                      WidgetsBinding.instance
                          .addPostFrameCallback((_) => showDialog(
                              context: context,
                              builder: (context) {
                                return BlocBuilder<HistoryBloc, HistoryState>(
                                  builder: (context, states) {
                                    if (states is HistoryLoadingState) {
                                      return Loader(
                                        text: '',
                                      );
                                    }
                                    return CustomPredictionDialog(
                                      price: "${state.price} Lacs",
                                      onOkPressed: () async {
                                        User user = await authRepository
                                            .getCurrentFirebaseUser();
                                        print(user.uid);
                                        //POSTING HISTORY
                                        HistoryModel historyModel =
                                            HistoryModel(
                                                id: 0,
                                                cc: cc,
                                                km: km,
                                                city: city,
                                                brand: widget.brandName,
                                                mode: mode,
                                                model: model,
                                                fuel_type: fuelType,
                                                price: state.price,
                                                user_id: user.uid,
                                                year: year);
                                        BlocProvider.of<HistoryBloc>(context)
                                            .add(
                                                PostHistoryEvent(historyModel));
                                        //-----------------------
                                        BlocProvider.of<UserBloc>(context)
                                            .add(UserGetEvent());
                                        BlocProvider.of<HistoryBloc>(context)
                                            .add(GetHistoryEvent());
                                        //-----------------------
                                        // CLOSING PREDICTION
                                        BlocProvider.of<FeatureBloc>(context)
                                            .add(SetIntial());
                                        Navigator.pop(context);
                                        return ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text('Saved succesfully.'),
                                          ),
                                        );
                                      },
                                      onCancelPressed: () {
                                        Navigator.pop(context);
                                        BlocProvider.of<FeatureBloc>(context)
                                            .add(SetIntial());
                                      },
                                    );
                                  },
                                );
                              }));
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * 0.08,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomBackButton(),
                            Text(
                              "Features",
                              style: theme.textTheme.headline1,
                            ),
                            SizedBox(
                              width: width * 0.1,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        CustomDropDown(
                            label: "Model",
                            value: 'Select model',
                            onChanged: (vals) {
                              setState(() {
                                model = vals;
                              });
                            },
                            list: widget.brandName == 'Honda'
                                ? data.honda
                                : widget.brandName == 'Toyota'
                                    ? data.toyota
                                    : data.suzuki),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        CustomDropDown(
                            label: "City",
                            value: 'Karachi',
                            onChanged: (vals) {
                              setState(() {
                                city = vals;
                              });
                            },
                            list: data.city),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        CustomDropDown(
                            label: "Fuel type",
                            value: 'Petrol',
                            onChanged: (vals) {
                              setState(() {
                                fuelType = vals;
                              });
                            },
                            list: data.fuel),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        CustomDropDown(
                            label: "Mode",
                            value: 'Automatic',
                            onChanged: (vals) {
                              setState(() {
                                mode = vals;
                              });
                            },
                            list: data.mode),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        CustomDropDown(
                            label: "Year",
                            value: '2010',
                            onChanged: (vals) {
                              setState(() {
                                year = vals;
                              });
                            },
                            list: data.year),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        CustomDropDown(
                            label: "CC",
                            value: '2000',
                            onChanged: (vals) {
                              setState(() {
                                cc = vals;
                              });
                            },
                            list: data.cc),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        CustomDropDown(
                            label: "KM",
                            value: '10000',
                            onChanged: (vals) {
                              setState(() {
                                km = vals;
                              });
                            },
                            list: data.km),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        CustomGradientButton(
                          name: "Predict",
                          withImage: false,
                          onPressed: () {
                            if (model == 'Select model') {
                              return ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Please select a model'),
                                ),
                              );
                            } else {
                              FeatureModel featureModel = FeatureModel(
                                  brand: widget.brandName,
                                  cc: int.parse(cc),
                                  city: city,
                                  fuel_type: fuelType,
                                  km: int.parse(km),
                                  mode: mode,
                                  model: model,
                                  year: int.parse(year));
                              BlocProvider.of<FeatureBloc>(context)
                                  .add(GetPrice(featureModel));
                            }
                          },
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                      ],
                    );
                  },
                )),
          ),
        ],
      ),
    );
  }
}
