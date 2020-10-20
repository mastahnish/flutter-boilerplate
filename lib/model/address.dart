import 'package:htd_poc/model/geo_coordinates.dart';
import 'package:json_annotation/json_annotation.dart';

part 'address.g.dart';

@JsonSerializable()
class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoCoordinates geo;

  Address(this.street, this.suite, this.city, this.zipcode, this.geo);

  factory Address.fromJson(dynamic json) => _$AddressFromJson(json);

  @override
  String toString() => '$street $suite, $zipcode, $city';
}
