import 'package:json_annotation/json_annotation.dart';

part 'geo_coordinates.g.dart';

@JsonSerializable()
class GeoCoordinates {
  final String lat;
  final String lon;

  GeoCoordinates(this.lat, this.lon);

  factory GeoCoordinates.fromJson(dynamic json) =>
      _$GeoCoordinatesFromJson(json);
}
