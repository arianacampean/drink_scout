import 'package:dio/dio.dart';
import 'package:drink_scout/model/drinks.dart';
import 'package:drink_scout/model/drinksDTO.dart';
import 'package:drink_scout/model/recipes.dart';
import 'package:retrofit/http.dart';

import 'apis.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: "http://127.0.0.1:8000/api/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String? baseUrl}) = _ApiClient;

  // @GET(Apis.drinks)
  // Future<ResponseData> getDrinks();

  @GET("/cat")
  Future<List<DrinksDto>> getCategories();

  @GET("/drinks")
  Future<List<Drinks>> getDr();

  @GET("/drinksCat/{cat}")
  Future<List<Drinks>> getDrinksByCat(@Path("cat") String nume);

  @GET("/recipes/{id}")
  Future<List<Recipes>> getRecipesById(@Path("id") int id);

  @POST("/drinks")
  Future<Drinks> addDrinks(@Body() Drinks dr);

  @POST("/recipes")
  Future<Recipes> addRecipes(@Body() Recipes re);

  @DELETE("/deleteDr/{id}")
  Future<void> deleteDr(@Path("id") int id);

  @DELETE("/deleteRe/{id}")
  Future<void> deleteRe(@Path("id") int id);

  @PUT("/updateDr/{id}")
  Future<void> updateDr(@Path("id") int id, @Body() Drinks dr);

  @PUT("/updateRe/{id}")
  Future<void> updateRe(@Path("id") int id, @Body() Recipes re);
}
