import 'package:json_annotation/json_annotation.dart';
part 'feature_model.g.dart';

@JsonSerializable()
class FeatureModel {
  String brand;
  String model;
  String city;
  String mode;
  String fuel_type;
  int cc;
  int km;
  int year;
  FeatureModel(
      {this.brand,
      this.cc,
      this.city,
      this.fuel_type,
      this.km,
      this.mode,
      this.model,
      this.year});

  factory FeatureModel.fromJson(Map<String, dynamic> data) =>
      _$FeatureModelFromJson(data);
  Map<String, dynamic> toJson() => _$FeatureModelToJson(this);
}
