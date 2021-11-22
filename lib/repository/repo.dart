import 'dart:collection';
import 'dart:developer';

import 'package:drink_scout/database/data.dart';
import 'package:drink_scout/model/drinks.dart';
import 'package:drink_scout/model/recipes.dart';
import 'package:flutter/cupertino.dart';

class Repo {
  List<Drinks> drinks = [];
  List<String> categories = [];
  List<Recipes> recipes = [];
  Map map = Map<String, List<String>>();

  Repo() {}
  static final Repo repo = Repo();

  List<String> addCategories(List<dynamic> cat) {
    cat.forEach((element) {
      categories.add(element);
    });
    return categories;
  }

  List<String> getCategories() {
    return categories;
  }

  List<Drinks> addDrinks(List<dynamic> dr) {
    dr.forEach((element) {
      drinks.add(element);
    });
    return drinks;
  }

  List<Recipes> addRecipes(List<dynamic> res) {
    res.forEach((element) {
      recipes.add(element);
    });
    return recipes;
  }

  Map getDrinksByCategory() {
    drinks.forEach((element) {
      if (map.containsKey(element.categorie)) {
        List<String> list = map[element.categorie];
        list.add(element.nume);
        map[element.categorie] = list;
      } else {
        List<String> list2 = [];
        list2.add(element.nume);
        map[element.categorie] = list2;
      }
    });
    return map;
  }

  List<String> getListForCategories(String cat) {
    return map[cat];
  }

  Drinks getDrinkByName(String name) {
    late Drinks sr;
    drinks.forEach((element) {
      if (element.nume == name) {
        sr = element;
      }
    });
    return sr;
  }

  List<Recipes> getRecipesforDrinks(int id) {
    List<Recipes> res = [];
    recipes.forEach((element) {
      if (element.idBautura == id) res.add(element);
    });
    return res;
  }

  void updateDrinks(Drinks dr) {
    drinks.forEach((element) {
      if (element.id == dr.id) {
        element.modPreparare = dr.modPreparare;
        element.nume = dr.nume;
      }
    });
  }

  void UpdateRes(Recipes res1, Recipes res2) {
    recipes.forEach((element) {
      if (element.id == res1.id) {
        element.cantitate = res1.cantitate;
        element.ingredient = res1.ingredient;
        element.unitateDeMasura = res1.unitateDeMasura;
      }
      if (element.id == res2.id) {
        element.cantitate = res2.cantitate;
        element.ingredient = res2.ingredient;
        element.unitateDeMasura = res2.unitateDeMasura;
      }
    });
  }

  void updateAll(Drinks sr, Recipes res, Recipes res2) {
    updateDrinks(sr);
    UpdateRes(res, res2);
  }

  void deleteDrink(Drinks dr) {
    drinks.remove(dr);
  }

  void deleteRes(Recipes res1, Recipes res2) {
    recipes.remove(res1);
    recipes.remove(res2);
  }

  void deleteAll(Drinks dr, Recipes res1, Recipes res2) {
    // List<String> list = map[dr.categorie];
    // if (list.length == 1) categories.remove(dr.categorie);
    // map.remove(dr.categorie);

    deleteDrink(dr);
    deleteRes(res1, res2);
  }

  void addNewRecipes(Drinks sr, Recipes res, Recipes res2) {
    drinks.add(sr);
    if (map.containsKey(sr.categorie)) {
      List<String> list = map[sr.categorie];
      list.add(sr.nume);
      map[sr.categorie] = list;
    } else {
      List<String> list = [];
      list.add(sr.nume);
      map[sr.categorie] = list;
      categories.add(sr.categorie);
    }
    recipes.add(res);
    recipes.add(res2);
  }
}
