import 'dart:developer';

import 'package:drink_scout/database/data.dart';
import 'package:drink_scout/model/drinks.dart';
import 'package:drink_scout/modelView/add_view.dart';
import 'package:drink_scout/modelView/drinks_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);
  @override
  _CategoriesView createState() => _CategoriesView();
}

class _CategoriesView extends State<Categories> {
  var items = [];
  late Map<String, int> items_map;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    getItems().whenComplete(() {
      setState(() {});
    });
  }

  Future getItems() async {
    setState(() => isLoading = true);
    var items2 = await DBProvider.db.getCategories();
    var items2_map = await DBProvider.db.getCategoriesMap();

    setState(() {
      isLoading = false;
      items = items2;
      items_map = items2_map;
      items_map.forEach((key, value) => {log(key + value.toString())});
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
              Drinks dr = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChosenCategory(cat: items[index])));
              setState(() {
                // log(dr.categorie);
                // items_map
                //     .forEach((key, value) => {log(key + value.toString())});
                int nr = items_map[dr.categorie]!;

                log("aici este nr" + nr.toString());
                if (nr == 1) {
                  log("sterge");
                  items.remove(dr.categorie);
                } else {
                  log("scade");
                  nr = nr - 1;
                  items_map[dr.categorie] = nr;
                }
              });
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
            Drinks dr = await Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddForm()));

            setState(() {
              if (!(items.contains(dr.categorie))) {
                items.add(dr.categorie);
                items_map[dr.categorie] = 1;
              } else {
                int nr = items_map[dr.categorie]!;
                nr = nr + 1;
                items_map[dr.categorie] = nr;
              }
            });
          }),
    );
    throw UnimplementedError();
  }
}
