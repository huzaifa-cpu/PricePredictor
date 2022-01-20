import 'dart:convert';

import 'package:http/http.dart';
import 'package:price_predict_app/dynamic/models/feature_model.dart';
import 'package:price_predict_app/static/utils/constants.dart';

class PredictionRepository {
  Future<String> getPrediction(FeatureModel featureModel) async {
    CustomString strings = CustomString();

    dynamic encodeFeatures = jsonEncode(featureModel);
    Response response = await post(Uri.parse("${strings.endPoint}/predict"),
        body: encodeFeatures, headers: {'content-type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic priceJson = jsonDecode(response.body);
      print(priceJson.toString());
      return priceJson.toString();
    } else {
      print('no price');
    }
  }
}
