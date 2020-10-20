import 'package:htd_poc/model/address.dart';
import 'package:htd_poc/model/company.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;
  final String phone;
  final String website;
  final Company company;

  User(this.id, this.name, this.username, this.email, this.address, this.phone,
      this.website, this.company);

  factory User.fromJson(dynamic json) => _$UserFromJson(json);
}
