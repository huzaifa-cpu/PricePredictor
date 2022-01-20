// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeatureModel _$FeatureModelFromJson(Map<String, dynamic> json) {
  return FeatureModel(
    brand: json['brand'] as String,
    cc: json['cc'] as int,
    city: json['city'] as String,
    fuel_type: json['fuel_type'] as String,
    km: json['km'] as int,
    mode: json['mode'] as String,
    model: json['model'] as String,
    year: json['year'] as int,
  );
}

Map<String, dynamic> _$FeatureModelToJson(FeatureModel instance) =>
    <String, dynamic>{
      'brand': instance.brand,
      'model': instance.model,
      'city': instance.city,
      'mode': instance.mode,
      'fuel_type': instance.fuel_type,
      'cc': instance.cc,
      'km': instance.km,
      'year': instance.year,
    };
