import 'package:json_annotation/json_annotation.dart';

part 'company.g.dart';

@JsonSerializable()
class Company {
  final String name;
  final String catchPhrase;
  final String bs;

  Company(this.name, this.catchPhrase, this.bs);
  factory Company.fromJson(dynamic json) => _$CompanyFromJson(json);
}
