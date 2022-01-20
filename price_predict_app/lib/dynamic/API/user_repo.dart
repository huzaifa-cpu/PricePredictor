import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:price_predict_app/dynamic/firebase/auth_repository.dart';
import 'package:price_predict_app/dynamic/models/user_model.dart';
import 'package:price_predict_app/static/utils/constants.dart';

class UserRepository {
  AuthRepository authRepository = AuthRepository();
  CustomString strings = CustomString();

  Future getUser() async {
    User user = await authRepository.getCurrentFirebaseUser();
    Response response = await get(
        Uri.parse("${strings.endPoint}/get-user/${user.uid}"),
        headers: {"content-type": 'application/json'});
    if (response.body.isNotEmpty) {
      Map body = jsonDecode(response.body);
      if (body.containsKey('id')) {
        UserModel userModel = UserModel.fromJson(body);
        print(userModel);
        return userModel;
      } else if (body.containsKey('detail')) {
        return body;
      }
    } else {
      print('no user model');
    }
  }

  Future<UserModel> insertUser(UserModel userModel) async {
    dynamic userEncode = jsonEncode(userModel);
    Response response = await post(Uri.parse("${strings.endPoint}/post-user"),
        body: userEncode, headers: {'content-type': 'application/json'});
    if (response.body.isNotEmpty) {
      dynamic body = jsonDecode(response.body);
      UserModel userModel = UserModel.fromJson(body);
      print('User inserted');
      return userModel;
    } else {
      print('no user model');
    }
  }

  Future<UserModel> updateUser(UserModel userModel) async {
    dynamic userEncode = jsonEncode(userModel);
    Response response = await put(
        Uri.parse("${strings.endPoint}/put-user/${userModel.id}"),
        body: userEncode,
        headers: {'content-type': 'application/json'});
    if (response.statusCode == 202) {
      print('updated successfully');
    } else {
      print('not updated');
    }
  }

  //START SERVER
  Future startServer() async {
    Response response = await get(
        Uri.parse("${strings.endPoint}/get-user/${1}"),
        headers: {"content-type": 'application/json'});
    print('SERVER STARTED');
  }
}
