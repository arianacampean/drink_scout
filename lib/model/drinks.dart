import 'package:json_annotation/json_annotation.dart';

part 'drinks.g.dart';

final String DrinksTable = "drinks";

class DrinksFileds {
  static final List<String> values = [id, nume, modPreparare, categorie];
  static final String id = "id";
  static final String nume = "nume";
  static final String modPreparare = "mod_preparare";
  static final String categorie = "categorie";
}

@JsonSerializable()
class Drinks {
  int? id;
  String nume;
  String modPreparare;
  String categorie;

  Drinks(
      {this.id,
      required this.nume,
      required this.modPreparare,
      required this.categorie});

  factory Drinks.fromJson(Map<String, dynamic> json) => _$DrinksFromJson(json);
  Map<String, dynamic> toJson() => _$DrinksToJson(this);
}

// @JsonSerializable()
// class ResponseData {
//   int code;
//   dynamic meta;
//   List<dynamic> data;
//   ResponseData({required this.code, this.meta, required this.data});
//   factory ResponseData.fromJson(Map<String, dynamic> json) =>
//       _$ResponseDataFromJson(json);
//   Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
// }
  // M

  // Map<String, Object?> toMap() {
  //   var map = <String, dynamic>{
  //     DrinksFileds.id: id,
  //     DrinksFileds.nume: nume,
  //     DrinksFileds.categorie: categorie,
  //     DrinksFileds.modPreparare: modPreparare
  //   };
  //   map.removeWhere((key, value) => value == null);
  //   return map;
  // }

  // Drinks copy({
  //   int? id,
  //   String? nume,
  //   String? modPreparare,
  //   String? categorie,
  // }) =>
  //     Drinks(
  //       id: id ?? this.id,
  //       nume: nume ?? this.nume,
  //       categorie: categorie ?? this.categorie,
  //       modPreparare: modPreparare ?? this.modPreparare,
  //     );

  // static Drinks fromJson(Map<String, Object?> json) => Drinks(
  //       id: json[DrinksFileds.id] as int?,
  //       nume: json[DrinksFileds.nume] as String,
  //       modPreparare: json[DrinksFileds.modPreparare] as String,
  //       categorie: json[DrinksFileds.categorie] as String,
  //     );
//}
