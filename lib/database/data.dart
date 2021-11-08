import 'dart:async';
import 'package:drink_scout/model/User.dart';
import 'package:drink_scout/model/drinks.dart';
import 'package:drink_scout/model/recipes.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('DScout.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    WidgetsFlutterBinding.ensureInitialized();
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const text = 'TEXT NOT NULL';
    const id = 'INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL';
    const int = 'INTEGER NOT NULL';
    await db.execute('''
      CREATE TABLE $DrinksTable(
        ${DrinksFileds.id} $id,
        ${DrinksFileds.nume} $text,
        ${DrinksFileds.categorie} $text,
        ${DrinksFileds.modPreparare} $text
        )
      ''');
    await db.execute('''
      CREATE TABLE $RecipesTable(
        ${RecipesFileds.id} $id,
        ${RecipesFileds.idBautura} $int,
        ${RecipesFileds.ingredient} $text,
        ${RecipesFileds.cantitate} $int,
         ${RecipesFileds.unitMas} $text
         )

      ''');
    await db.execute('''
      CREATE TABLE $UserTable(
        ${UserFileds.id} $id,
        ${UserFileds.username} $text,
        ${UserFileds.parola} $text,
        ${UserFileds.tip} $text
        )
      ''');
  }

  Future close() async {
    final data = await db.database;
    data.close();
  }

  Future<Drinks> addDrinks(Drinks drinks) async {
    final data = await db.database;
    final id = await data.insert(DrinksTable, drinks.toMap());
    return drinks.copy(id: id);
  }

  Future<int> addRecipes(Recipes recipes) async {
    final data = await db.database;
    final id = await data.insert(RecipesTable, recipes.toMap());
    return id;
  }

  Future<List<Drinks>> getDrinks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(DrinksTable);

    return List.generate(maps.length, (i) {
      return Drinks(
          id: maps[i]['id'],
          nume: maps[i]['nume'],
          categorie: maps[i]['categorie'],
          modPreparare: maps[i]['mod_preparare']);
    });
  }

  Future<List> getCategories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(DrinksTable);
    var cat = [];
    List.generate(maps.length, (i) {
      if (!(cat.contains(maps[i]["categorie"]))) {
        cat.add(maps[i]["categorie"]);
      }
    });
    return cat;
  }

  Future<Map<String, int>> getCategoriesMap() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(DrinksTable);
    Map<String, int> cat_map = {};
    int index = 1;
    List.generate(maps.length, (i) {
      if (cat_map.containsKey(maps[i]["categorie"])) {
        int nr = cat_map[maps[i]["categorie"]]!;
        nr = nr + 1;
        cat_map[maps[i]["categorie"]] = nr;
      } else {
        cat_map[maps[i]["categorie"]] = index;
      }
    });
    return cat_map;
  }

  Future<List> getDrinkByCategory(String cat) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(DrinksTable);
    var dr = [];
    List.generate(maps.length, (i) {
      if (maps[i]['categorie'] == cat) dr.add(maps[i]['nume']);
    });
    return dr;
  }

  Future<List<Recipes>> getRecipes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(RecipesTable);

    return List.generate(maps.length, (i) {
      return Recipes(
          id: maps[i][RecipesFileds.id],
          idBautura: maps[i][RecipesFileds.idBautura],
          ingredient: maps[i][RecipesFileds.ingredient],
          cantitate: maps[i][RecipesFileds.cantitate],
          unitateDeMasura: maps[i][RecipesFileds.unitMas]);
    });
  }

  Future<List<Recipes>> getRecipesById(int id) async {
    final db = await database;
    final maps = await db.query(
      RecipesTable,
      columns: RecipesFileds.values,
      where: '${RecipesFileds.idBautura}=?',
      whereArgs: [id],
    );

    return List.generate(maps.length, (i) {
      return Recipes.fromJson(maps[i]);
    });

    //return null;
  }

  Future<Drinks> getDrinkByName(String nume) async {
    final db = await database;
    final maps = await db.query(
      DrinksTable,
      columns: DrinksFileds.values,
      where: '${DrinksFileds.nume}=?',
      whereArgs: [nume],
    );

    return Drinks.fromJson(maps.first);
  }

  Future<void> updateDrinks(Drinks drink) async {
    // Get a reference to the database.
    final db = await database;
    // Update the given Dog.
    await db.update(
      DrinksTable,
      drink.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [drink.id],
    );
  }

  Future<void> updateRecipes(Recipes res) async {
    // Get a reference to the database.
    final db = await database;
    // Update the given Dog.
    await db.update(
      RecipesTable,
      res.toMap(),
      where: 'id = ?',
      whereArgs: [res.id],
    );
  }

  Future<void> deleteDrink(int id) async {
    // Get a reference to the database.
    final db = await database;
    await db.delete(
      DrinksTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteRecipes(int id) async {
    // Get a reference to the database.
    final db = await database;
    await db.delete(
      RecipesTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
