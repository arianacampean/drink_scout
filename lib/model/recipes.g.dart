// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Recipes _$RecipesFromJson(Map<String, dynamic> json) => Recipes(
      id: json['id'] as int?,
      idBautura: json['idBautura'] as int,
      ingredient: json['ingredient'] as String,
      cantitate: json['cantitate'] as int,
      unitateDeMasura: json['unitateDeMasura'] as String,
    );

Map<String, dynamic> _$RecipesToJson(Recipes instance) => <String, dynamic>{
      'id': instance.id,
      'idBautura': instance.idBautura,
      'ingredient': instance.ingredient,
      'cantitate': instance.cantitate,
      'unitateDeMasura': instance.unitateDeMasura,
    };
