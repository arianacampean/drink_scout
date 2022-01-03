import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:drink_scout/database/data.dart';
import 'package:drink_scout/model/drinks.dart';
import 'package:drink_scout/model/recipes.dart';
import 'package:drink_scout/modelView/categories_view.dart';
import 'package:drink_scout/repository/app_repo.dart';
import 'package:drink_scout/repository/repo.dart';
import 'package:drink_scout/retrofit/api_client.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CentralForm extends StatefulWidget {
  Drinks dr;
  Repo repo;
  int first_time;

  CentralForm(
      {Key? key,
      required this.dr,
      required this.repo,
      required this.first_time})
      : super(key: key);

  @override
  CentraloFormState createState() {
    return CentraloFormState();
  }
}

class CentraloFormState extends State<CentralForm> {
  var name;
  late List<Recipes> res;
  // String nume = widget.dr.nume;
  var btnTextt = "Modifica";
  //late Drinks dr;
  bool redonl = true;
  bool isLoading = false;
  var numess;
  late AppRepository appRepository;
  //var cat;
  // var ing;
  // var unit;
  var mod;
  // var cant;
  // var cant2;
  // var ing2;
  // var unit2;
  var ing = TextEditingController();
  var cant = TextEditingController();
  var unit = TextEditingController();
  var ing2 = TextEditingController();
  var cant2 = TextEditingController();
  var unit2 = TextEditingController();
  Color c = Colors.grey;
  @override
  void initState() {
    super.initState();
    appRepository = AppRepository(widget.repo);

    numess = TextEditingController(text: widget.dr.nume);
    mod = TextEditingController(text: widget.dr.modPreparare);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const title = "Recipes";
    return Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: _buildBody(context));
    // Build a Form widget using the _formKey created above.
  }

  home(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 70.0,
          ),
          _buildName(),
          const SizedBox(
            height: 80.0,
          ),
          _buildRow(),
          const SizedBox(
            height: 70.0,
          ),
          _buildRow2(),
          const SizedBox(
            height: 70.0,
          ),
          _buildMod(),
          const SizedBox(
            height: 50.0,
          ),
          _buildBtn(),

          //  _buildBtn2()
        ]),
      ),
    );
  }

  Widget _buildName() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.all(20),
        width: 150,
        child: TextField(
          textAlign: TextAlign.center,
          readOnly: redonl,
          // style: TextStyle(color: Colors.red),
          onChanged: (text) {
            setState(() {
              // widget.dr.nume = text;
              widget.dr.nume = text;
            });
          },
          controller: numess,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.coffee_maker_outlined),
            // hintText: widget.dr.nume,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: c),
            ),
          ),
        ),
      ),
    );
  }

  FutureBuilder<List<Recipes>> _buildBody(BuildContext context) {
    List<Recipes> ls = widget.repo.getRecipesforDrinks(widget.dr.id!);
    if (ls.length == 0) {
      final client =
          ApiClient(Dio(BaseOptions(contentType: "application/json")));
      setState(() {
        widget.first_time = 1;
      });
      return FutureBuilder<List<Recipes>>(
        future: client.getRecipesById(widget.dr.id!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            log('iau acum datele pentru central');
            res = snapshot.data!;

            ing.text = res[0].ingredient;
            cant.text = res[0].cantitate.toString();
            unit.text = res[0].unitateDeMasura;
            ing2.text = res[1].ingredient;
            cant2.text = res[1].cantitate.toString();
            unit2.text = res[1].unitateDeMasura;
            widget.repo.addRecipes(res);
            return home(context);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
    } else {
      res = ls;
      if (widget.first_time == 0) {
        setState(() {
          widget.first_time = 1;
        });
        ing.text = res[0].ingredient;
        cant.text = res[0].cantitate.toString();
        unit.text = res[0].unitateDeMasura;
        ing2.text = res[1].ingredient;
        cant2.text = res[1].cantitate.toString();
        unit2.text = res[1].unitateDeMasura;
      }

      return FutureBuilder(
        future: null,
        builder: (context, snapshot) {
          return home(context);
        },
      );
    }
  }

  Widget _buildRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        const SizedBox(
          width: 20.0,
        ),
        Flexible(
          child: TextFormField(
            validator: (ingr1) {
              if (ingr1 == null || ingr1.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: ing,
            onChanged: (text) {
              setState(() {
                //widget.res[0].ingredient = text;
                res[0].ingredient = text;
              });
            },
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: c),
              ),
            ),
            readOnly: redonl,
            textAlign: TextAlign.center,
            // initialValue: widget.res[0].ingredient,
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Flexible(
          child: TextFormField(
            validator: (can1) {
              if (can1 == null || can1.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: cant,
            onChanged: (text) {
              setState(() {
                //widget.res[0].cantitate = int.parse(text);
                res[0].cantitate = int.parse(text);
              });
            },
            // keyboardType: TextInputType.number,
            readOnly: redonl,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: c),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Flexible(
          child: TextFormField(
            validator: (unit1) {
              if (unit1 == null || unit1.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            readOnly: redonl,
            onChanged: (text) {
              setState(() {
                //widget.res[0].unitateDeMasura = text;
                res[0].unitateDeMasura = text;
              });
            },
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: c),
              ),
            ),
            controller: unit,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
      ],
    );
  }

  Widget _buildRow2() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        const SizedBox(
          width: 20.0,
        ),
        Flexible(
          child: TextFormField(
            validator: (ingr1) {
              if (ingr1 == null || ingr1.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            readOnly: redonl,
            controller: ing2,
            onChanged: (text) {
              setState(() {
                // widget.res[1].ingredient = text;
                res[1].ingredient = text;
              });
            },
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: c),
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Flexible(
          child: TextFormField(
            validator: (can1) {
              if (can1 == null || can1.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            readOnly: redonl,
            controller: cant2,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: c),
              ),
            ),
            onChanged: (text) {
              setState(() {
                //widget.res[1].cantitate = int.parse(text);
                res[1].cantitate = int.parse(text);
              });
            },
            //  keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Flexible(
          child: TextFormField(
            validator: (unit1) {
              if (unit1 == null || unit1.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: unit2,
            readOnly: redonl,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: c),
              ),
            ),
            onChanged: (text) {
              setState(() {
                // widget.res[1].unitateDeMasura = text;
                res[1].unitateDeMasura = text;
              });
            },
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
      ],
    );
  }

  Widget _buildMod() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: TextFormField(
        validator: (mod) {
          if (mod == null || mod.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        controller: mod,
        readOnly: redonl,
        onChanged: (text) {
          setState(() {
            // widget.dr.modPreparare = text;
            widget.dr.modPreparare = text;
          });
        },
        //  initialValue: widget.dr.modPreparare,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.coffee_maker_outlined),
          contentPadding: EdgeInsets.symmetric(vertical: 120, horizontal: 20),
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: c),
          ),
        ),
      ),
    );
  }

  Widget _buildBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // ignore: prefer_const_literals_to_create_immutables
      children: <Widget>[
        const SizedBox(
          width: 20.0,
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: ElevatedButton(
            onPressed: () async {
              showAlertDialog(context);
            },
            child: const Text('Sterge'),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        Align(
          // padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.bottomLeft,
          child: ElevatedButton(
            onPressed: () async {
              if (btnTextt == "Salveaza") {
                Drinks drin = Drinks(
                    id: widget.dr.id,
                    nume: widget.dr.nume,
                    modPreparare: widget.dr.modPreparare,
                    categorie: widget.dr.categorie);
                Recipes res1 = Recipes(
                    id: res[0].id,
                    idBautura: res[0].idBautura,
                    ingredient: res[0].ingredient,
                    cantitate: res[0].cantitate,
                    unitateDeMasura: res[0].unitateDeMasura);

                Recipes res2 = Recipes(
                    id: res[1].id,
                    idBautura: res[1].idBautura,
                    ingredient: res[1].ingredient,
                    cantitate: res[1].cantitate,
                    unitateDeMasura: res[1].unitateDeMasura);

                bool good = true;
                // showAlertDialog(context);
                try {
                  appRepository.updateAll(drin, res1, res2);
                } catch (e) {
                  good = false;
                }
                if (good == false) {
                  showAlertDialogExceptions(
                      context, 'Eroare', 'Eroare la modificare');
                } else {
                  final snackBar = SnackBar(
                    content: Builder(builder: (context) {
                      return const Text('Modificarea a fost facuta');
                    }),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  setState(() {
                    redonl = true;
                    btnTextt = "Modifica";
                    c = Colors.grey;
                  });
                  //String s = widget.dr.nume + "+" + "m";
                  Navigator.pop(context, drin);
                }
              } else {
                setState(() {
                  redonl = false;
                  btnTextt = "Salveaza";
                  c = Colors.blue;
                });
              }
            },
            child: Text(btnTextt),
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Nu"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        // Navigator.pop(dialog)
      },
    );
    Widget continueButton = TextButton(
      child: Text("Da"),
      onPressed: () async {
        Navigator.of(context, rootNavigator: true).pop();

        bool good = true;
        try {
          appRepository.deleteAll(widget.dr, res[0], res[1]);
        } catch (e) {
          good = false;
        }
        if (good == false) {
          showAlertDialogExceptions(context, 'Eroare', 'Eroare la stergere');
        } else {
          Drinks drink = Drinks(
              nume: 'Sterge',
              modPreparare: 'modPreparare',
              categorie: 'categorie');

          Navigator.pop(context, drink);
          final snackBar = SnackBar(
            content: Builder(builder: (context) {
              return const Text('Bautura a fost stearsa');
            }),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Stergere reteta/bautura"),
      content: Text("Sigur vrei sa faci stergerea?"),
      actions: [
        cancelButton,
        continueButton,
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
