import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:drink_scout/database/data.dart';
import 'package:drink_scout/model/drinks.dart';
import 'package:drink_scout/model/recipes.dart';
import 'package:drink_scout/modelView/central_view.dart';
import 'package:drink_scout/repository/repo.dart';
import 'package:drink_scout/retrofit/api_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChosenCategory extends StatefulWidget {
  String cat;
  Repo repo;
  int test_stergere;

  ChosenCategory(
      {Key? key,
      required this.cat,
      required this.repo,
      required this.test_stergere})
      : super(key: key);
  @override
  _DrinksView createState() => _DrinksView();
}

class _DrinksView extends State<ChosenCategory> {
  var items = [];
  bool isLoading = false;
  List<Drinks> posts = [];

  @override
  void initState() {
    super.initState();
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
      body: _buildBody(context),
    );
    throw UnimplementedError();
  }

  FutureBuilder<List<Drinks>>? _buildBody(BuildContext context) {
    List<Drinks> ls = widget.repo.getDrinksByCategory(widget.cat);
    if (ls.length == 0 && widget.test_stergere == 0) {
      try {
        final client =
            ApiClient(Dio(BaseOptions(contentType: "application/json")));
        return FutureBuilder<List<Drinks>>(
          future: client.getDrinksByCat(widget.cat),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              log('in future la drinks');
              posts = snapshot.data!;
              widget.repo.addDrinks(posts);

              return _buildListView(context, posts);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        );
      } catch (_) {
        showAlertDialogExceptions(context, 'Eroare', 'Eroare la get drinks');
      }
    } else {
      return FutureBuilder<List<Drinks>>(
        future: null,
        builder: (context, snapshot) {
          if (widget.test_stergere == 0) {
            posts = ls;
          }
          return _buildListView(context, posts);
        },
      );
    }
  }

  Widget _buildListView(BuildContext context, List<Drinks> posts) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.asset('assets/images/imagess.jpg'),
          title: Text(posts[index].nume),
          onTap: () async {
            try {
              Drinks dr = await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CentralForm(
                        dr: posts[index],
                        repo: widget.repo,
                        first_time: 0,
                      )));

              setState(() {
                widget.test_stergere = 1;
                if (dr.nume == 'Sterge') {
                  posts.remove(posts[index]);
                } else {
                  posts.remove(posts[index]);
                  posts.add(dr);
                }
              });
            } catch (_) {
              log('nu ai modificat/sters');
            }
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
