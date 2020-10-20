// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_coordinates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoCoordinates _$GeoCoordinatesFromJson(Map<String, dynamic> json) {
  return GeoCoordinates(
    json['lat'] as String,
    json['lon'] as String,
  );
}

Map<String, dynamic> _$GeoCoordinatesToJson(GeoCoordinates instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
    };
