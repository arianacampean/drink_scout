import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:drink_scout/model/drinks.dart';
import 'package:drink_scout/model/recipes.dart';
import 'package:drink_scout/repository/repo.dart';
import 'package:drink_scout/retrofit/api_client.dart';

class AppRepository {
  late ApiClient _apiRequest;
  late Dio dio;
  late Repo repo;

  AppRepository(Repo repo) {
    this.repo = repo;
    dio = Dio(BaseOptions(contentType: "application/json"));
    _apiRequest = ApiClient(dio);
  }
  //static final AppRepository appRepository = AppRepository(repo);

  Future<Drinks?> addDrink2(Drinks dr, Recipes res1, Recipes res2) async {
    log('adaugare app_repo');
    final client = _apiRequest;
    try {
      Drinks drr = await client.addDrinks(dr);
      res1.idBautura = drr.id!;
      res2.idBautura = drr.id!;

      try {
        Recipes r = await client.addRecipes(res1);
        Recipes rr = await client.addRecipes(res2);
        List<Recipes> rs = [];
        rs.add(r);
        rs.add(rr);
        repo.addRecipes(rs);
        repo.addDrink(drr);
      } catch (_) {
        log('exceptie adaugare retete');
        rethrow;
      }

      return dr;
    } catch (_) {
      log('exceptie aduagare bautura');
      rethrow;
    }
  }

  Future deleteAll(Drinks dr, Recipes res1, Recipes res2) async {
    log('stergere app_repo');
    final client = _apiRequest;
    try {
      await client.deleteRe(res1.id!);
      await client.deleteRe(res2.id!);
      await client.deleteDr(dr.id!);
      repo.deleteAll(dr, res1, res2);
    } catch (_) {
      log('exceptie stergere');
      rethrow;
    }
  }

  Future updateAll(Drinks dr, Recipes res1, Recipes res2) async {
    log('update app_repo');
    final client = _apiRequest;
    try {
      await client.updateDr(dr.id!, dr);
      await client.updateRe(res1.id!, res1);
      await client.updateRe(res2.id!, res2);
      repo.updateAll(dr, res1, res2);
    } catch (_) {
      log('exceptie update ');
      rethrow;
    }
  }
}
