import 'dart:developer';

import 'package:drink_scout/database/data.dart';
import 'package:drink_scout/model/drinks.dart';
import 'package:drink_scout/modelView/add_view.dart';
import 'package:drink_scout/modelView/drinks_view.dart';
import 'package:drink_scout/repository/repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);
  @override
  _CategoriesView createState() => _CategoriesView();
}

class _CategoriesView extends State<Categories> {
  var items = [];
  late Repo repo;
  late Map<String, int> items_map;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    repo = Repo.repo;
    getItems().whenComplete(() {
      setState(() {
        // isLoading = false;
        // var items2 = repo.getCategories();
        // items = items2;
      });
    });
  }

  Future getItems() async {
    setState(() => isLoading = true);
    log("sper ca nu te repeti");
    var items2 = await DBProvider.db
        .getCategories()
        .then((value) => repo.addCategories(value));
    var drinks =
        await DBProvider.db.getDrinks().then((value) => repo.addDrinks(value));
    repo.getDrinksByCategory();

    await DBProvider.db.getRecipes().then((value) => repo.addRecipes(value));

    setState(() {
      isLoading = false;
      items = items2;
    });
  }

  @override
  Widget build(BuildContext context) {
    const title = "Categories List";

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset('assets/images/images.png'),
            title: Text(items[index]),
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ChosenCategory(cat: items[index], repo: repo)));
            },
            dense: false,
            // selected: true,
            subtitle: const Text("Bauturi"),
            trailing: Icon(Icons.more_vert),
            contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            Drinks dr = await Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddForm(repo: repo)));

            setState(() {
              log(dr.categorie);
              items.forEach((element) {
                log(element);
              });
            });
          }),
    );
    throw UnimplementedError();
  }
}
