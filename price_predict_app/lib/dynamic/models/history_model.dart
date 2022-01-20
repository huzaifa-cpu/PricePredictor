import 'package:json_annotation/json_annotation.dart';
part 'history_model.g.dart';

@JsonSerializable()
class HistoryModel {
  int id;
  String brand;
  String model;
  String city;
  String mode;
  String fuel_type;
  String cc;
  String km;
  String year;
  String price;
  String user_id;
  HistoryModel(
      {this.id,
      this.brand,
      this.cc,
      this.city,
      this.fuel_type,
      this.km,
      this.mode,
      this.model,
      this.year,
      this.price,
      this.user_id});

  factory HistoryModel.fromJson(Map<String, dynamic> data) =>
      _$HistoryModelFromJson(data);
  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
