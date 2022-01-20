// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryModel _$HistoryModelFromJson(Map<String, dynamic> json) {
  return HistoryModel(
    id: json['id'] as int,
    brand: json['brand'] as String,
    cc: json['cc'] as String,
    city: json['city'] as String,
    fuel_type: json['fuel_type'] as String,
    km: json['km'] as String,
    mode: json['mode'] as String,
    model: json['model'] as String,
    year: json['year'] as String,
    price: json['price'] as String,
    user_id: json['user_id'] as String,
  );
}

Map<String, dynamic> _$HistoryModelToJson(HistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brand': instance.brand,
      'model': instance.model,
      'city': instance.city,
      'mode': instance.mode,
      'fuel_type': instance.fuel_type,
      'cc': instance.cc,
      'km': instance.km,
      'year': instance.year,
      'price': instance.price,
      'user_id': instance.user_id,
    };
