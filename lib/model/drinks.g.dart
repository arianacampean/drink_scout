// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drinks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Drinks _$DrinksFromJson(Map<String, dynamic> json) => Drinks(
      id: json['id'] as int?,
      nume: json['nume'] as String,
      modPreparare: json['modPreparare'] as String,
      categorie: json['categorie'] as String,
    );

Map<String, dynamic> _$DrinksToJson(Drinks instance) => <String, dynamic>{
      'id': instance.id,
      'nume': instance.nume,
      'modPreparare': instance.modPreparare,
      'categorie': instance.categorie,
    };
