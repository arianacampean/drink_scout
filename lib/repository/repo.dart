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

  void addDrink(Drinks dr) {
    bool bun = false;
    drinks.forEach((element) {
      if (element.categorie == dr.categorie) bun = true;
    });
    if (bun == true) drinks.add(dr);
  }

  List<Recipes> addRecipes(List<dynamic> res) {
    res.forEach((element) {
      recipes.add(element);
    });
    return recipes;
  }

  List<Drinks> getDrinksByCategory(String cat) {
    List<Drinks> ls = [];
    drinks.forEach((element) {
      if (element.categorie == cat) ls.add(element);
    });

    return ls;
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
    int ind = 0;
    try {
      drinks.forEach((element) {
        if (element.id == dr.id) {
          throw "";
        }
        ind++;
      });
    } catch (e) {
      drinks.removeAt(ind);
      // leave it
    }
  }

  void deleteRes(Recipes res1, Recipes res2) {
    recipes.remove(res1);
    recipes.remove(res2);
  }

  void deleteAll(Drinks dr, Recipes res1, Recipes res2) {
    deleteDrink(dr);
    deleteRes(res1, res2);
  }

  void addNewRecipes(Drinks sr, Recipes res, Recipes res2) {
    drinks.add(sr);
    if (!categories.contains(sr.categorie)) categories.add(sr.categorie);

    recipes.add(res);
    recipes.add(res2);
  }
}
