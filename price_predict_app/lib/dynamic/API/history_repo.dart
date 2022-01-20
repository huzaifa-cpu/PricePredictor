import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:price_predict_app/dynamic/firebase/auth_repository.dart';
import 'package:price_predict_app/dynamic/models/history_model.dart';
import 'package:price_predict_app/static/utils/constants.dart';

class HistoryRepository {
  AuthRepository _authRepository = AuthRepository();
  CustomString strings = CustomString();

  Future<List<HistoryModel>> getHistoryByUserId() async {
    User user = await _authRepository.getCurrentFirebaseUser();
    print(user.uid);
    Response response = await get(
        Uri.parse("${strings.endPoint}/get-user-histories/${user.uid}"),
        headers: {"content-type": 'application/json'});
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<HistoryModel> historyModel =
          body.map((dynamic e) => HistoryModel.fromJson(e)).toList();
      print(historyModel);
      return historyModel;
    } else {
      print('no history');
    }
  }

  Future<HistoryModel> insertHistory(HistoryModel historyModel) async {
    dynamic historyEncode = jsonEncode(historyModel);
    Response response = await post(
        Uri.parse("${strings.endPoint}/post-history"),
        body: historyEncode,
        headers: {'content-type': 'application/json'});
    if (response.statusCode == 201) {
      print('history is inserted');
    } else {
      print('history is not inserted');
    }
  }

  Future<HistoryModel> deleteHistoryById(int id) async {
    Response response = await delete(
        Uri.parse("${strings.endPoint}/delete-history/${id}"),
        headers: {'content-type': 'application/json'});
    if (response.statusCode == 200) {
      print('history is delete');
    } else {
      print('not deleted');
    }
  }
}
