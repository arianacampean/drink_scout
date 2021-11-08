final String RecipesTable = "recipes";

class RecipesFileds {
  static final List<String> values = [
    id,
    idBautura,
    ingredient,
    cantitate,
    unitMas
  ];
  static final String id = "id";
  static final String idBautura = "id_bautura";
  static final String ingredient = "ingredient";
  static final String cantitate = "cantitate";
  static final String unitMas = "unit_mas";
}

class Recipes {
  int? id;
  int idBautura;
  String ingredient;
  int cantitate;
  String unitateDeMasura;
  Recipes(
      {this.id,
      required this.idBautura,
      required this.ingredient,
      required this.cantitate,
      required this.unitateDeMasura});

  Map<String, Object?> toMap() {
    var map = <String, dynamic>{
      RecipesFileds.id: id,
      RecipesFileds.idBautura: idBautura,
      RecipesFileds.ingredient: ingredient,
      RecipesFileds.cantitate: cantitate,
      RecipesFileds.unitMas: unitateDeMasura
    };
    map.removeWhere((key, value) => value == null);
    return map;
  }

  static Recipes fromJson(Map<String, Object?> json) => Recipes(
        id: json[RecipesFileds.id] as int?,
        idBautura: json[RecipesFileds.idBautura] as int,
        ingredient: json[RecipesFileds.ingredient] as String,
        cantitate: json[RecipesFileds.cantitate] as int,
        unitateDeMasura: json[RecipesFileds.unitMas] as String,
      );
}
