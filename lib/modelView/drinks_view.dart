import 'dart:developer';

import 'package:drink_scout/database/data.dart';
import 'package:drink_scout/model/drinks.dart';
import 'package:drink_scout/model/recipes.dart';
import 'package:drink_scout/modelView/central_view.dart';
import 'package:drink_scout/repository/repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChosenCategory extends StatefulWidget {
  final String cat;
  final Repo repo;

  const ChosenCategory({Key? key, required this.cat, required this.repo})
      : super(key: key);
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
    log("aiciii");
    var items2 = widget.repo.getListForCategories(widget.cat);
    // var ceva2 = widget.repo
    //     .getCategories(); //var items2 = await Repo.repo.getCategories();
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
              var s = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CentralForm(
                        namee: items[index],
                        repo: widget.repo,
                      )));

              setState(() {
                var str = s.split("+");
                if (str[1] == "m") {
                  log("fac modificare");
                  items.remove(items[index]);
                  items.add(str[0]);
                } else {
                  items.remove(items[index]);
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
}
