import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String id;
  String email;
  String name;
  String photo;
  UserModel({this.email, this.id, this.name, this.photo});

  factory UserModel.fromJson(Map<String, dynamic> data) =>
      _$UserModelFromJson(data);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
