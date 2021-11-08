import 'dart:developer';

import 'package:drink_scout/database/data.dart';
import 'package:drink_scout/model/drinks.dart';
import 'package:drink_scout/model/recipes.dart';
import 'package:drink_scout/modelView/central_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChosenCategory extends StatefulWidget {
  final String cat;

  const ChosenCategory({Key? key, required this.cat}) : super(key: key);
  @override
  _DrinksView createState() => _DrinksView();
}

class _DrinksView extends State<ChosenCategory> {
  var items = [];
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
    var items2 = await DBProvider.db.getDrinkByCategory(widget.cat);

    setState(() {
      isLoading = false;
      items = items2;
    });
  }

  @override
  Widget build(BuildContext context) {
    //getItems();
    const title = "Drinks List";
    return Scaffold(
      // home: Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset('assets/images/imagess.jpg'),
            title: Text(items[index]),
            onTap: () async {
              Drinks dr = await getDrink(items[index]);
              List<Recipes> res = await getR(dr.id!);
              var s = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      CentralForm(namee: items[index], dr: dr, res: res)));

              setState(() {
                log("da");
                var str = s.split("+");
                if (str[1] == "m") {
                  log("da");
                  items.remove(items[index]);
                  items.add(str[0]);
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
      // ),
    );
    throw UnimplementedError();
  }

  Future<Drinks> getDrink(String nume) async {
    //setState(() => isLoading = true);
    Drinks items2 = await DBProvider.db.getDrinkByName(nume);
    return items2;
  }

  Future<List<Recipes>> getR(int id) async {
    //setState(() => isLoading = true);
    List<Recipes> res = await DBProvider.db.getRecipesById(id);
    return res;
  }
}
