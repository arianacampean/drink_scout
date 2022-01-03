import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:drink_scout/database/data.dart';
import 'package:drink_scout/model/drinks.dart';
import 'package:drink_scout/modelView/add_view.dart';
import 'package:drink_scout/modelView/drinks_view.dart';
import 'package:drink_scout/repository/repo.dart';
import 'package:drink_scout/retrofit/api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drink_scout/model/drinksDTO.dart';

import '../main.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);
  @override
  _CategoriesView createState() => _CategoriesView();
}

class _CategoriesView extends State<Categories> {
  List<DrinksDto> posts = [];
  List<String> posts_filter = [];
  late Repo repo;
  late Map<String, int> items_map;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    repo = Repo.repo;
  }

  @override
  Widget build(BuildContext context) {
    const title = "Categories List";
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: _buildBody(context),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            try {
              Drinks dr = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddForm(repo: repo)));

              setState(() {
                if (!posts_filter.contains(dr.categorie)) {
                  posts_filter.add(dr.categorie);
                }
              });
            } catch (_) {
              log('nu ai adaugat');
            }
          }),
    );
    throw UnimplementedError();
  }

  FutureBuilder<List<DrinksDto>>? _buildBody(BuildContext context) {
    List<String> ls = repo.getCategories();
    if (ls.length == 0) {
      try {
        final client =
            ApiClient(Dio(BaseOptions(contentType: "application/json")));
        return FutureBuilder<List<DrinksDto>>(
          future: client.getCategories(),
          builder: (context, snapshot) {
            log("sunt in future de la categorii");
            if (snapshot.connectionState == ConnectionState.done) {
              posts = snapshot.data!;
              posts.forEach((element) {
                if (!posts_filter.contains(element.categorie)) {
                  posts_filter.add(element.categorie);
                }
              });
              repo.addCategories(posts_filter);

              return _buildListView(context, posts_filter);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      } catch (_) {
        showAlertDialogExceptions(
            context, 'Eroare', 'Eroare la get categories');
      }
    } else {
      return FutureBuilder<List<DrinksDto>>(
        future: null,
        builder: (context, snapshot) {
          // posts_filter = ls;

          return _buildListView(context, posts_filter);
        },
      );
    }
  }

  Widget _buildListView(BuildContext context, List<String> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.asset('assets/images/images.png'),
          title: Text(posts[index]),
          onTap: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChosenCategory(
                          repo: repo,
                          cat: posts[index],
                          test_stergere: 0,
                        )));
          },
          dense: false,
          // selected: true,
          subtitle: const Text("Bauturi"),
          trailing: Icon(Icons.more_vert),
          contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        );
      },
    );
  }

  showAlertDialogExceptions(BuildContext context, String tittl, String mes) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        // Navigator.pop(dialog)
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(tittl),
      content: Text(mes),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
