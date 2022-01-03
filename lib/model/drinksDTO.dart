// ignore: file_names
import 'package:json_annotation/json_annotation.dart';
part 'drinksDTO.g.dart';

@JsonSerializable()
class DrinksDto {
  String categorie;

  DrinksDto({required this.categorie});

  factory DrinksDto.fromJson(Map<String, dynamic> json) =>
      _$DrinksDtoFromJson(json);
  Map<String, dynamic> toJson() => _$DrinksDtoToJson(this);
}
