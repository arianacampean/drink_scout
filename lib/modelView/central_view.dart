import 'dart:developer';
import 'dart:io';

import 'package:drink_scout/database/data.dart';
import 'package:drink_scout/model/drinks.dart';
import 'package:drink_scout/model/recipes.dart';
import 'package:drink_scout/modelView/categories_view.dart';
import 'package:drink_scout/repository/repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CentralForm extends StatefulWidget {
  String namee;
  Repo repo;

  CentralForm({Key? key, required this.namee, required this.repo})
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
  late Drinks dr;
  bool redonl = true;
  bool isLoading = false;
  var numess;
  //var cat;
  var ing;
  var unit;
  var mod;
  var cant;
  var cant2;
  var ing2;
  var unit2;
  Color c = Colors.grey;
  @override
  void initState() {
    super.initState();
    dr = widget.repo.getDrinkByName(widget.namee);
    log(dr.id.toString());
    res = widget.repo.getRecipesforDrinks(dr.id!);
    numess = TextEditingController(text: dr.nume);
    ing = TextEditingController(text: res[0].ingredient);
    cant = TextEditingController(text: res[0].cantitate.toString());
    unit = TextEditingController(text: res[0].unitateDeMasura);
    ing2 = TextEditingController(text: res[1].ingredient);
    cant2 = TextEditingController(text: res[1].cantitate.toString());
    unit2 = TextEditingController(text: res[1].unitateDeMasura);
    mod = TextEditingController(text: dr.modPreparare);
  }

  final _formKey = GlobalKey<FormState>();
  //var numess = TextEditingController(text: "ana");

  @override
  Widget build(BuildContext context) {
    const title = "Recipes";
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: home(),
    );
    // Build a Form widget using the _formKey created above.
  }

  home() {
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
              dr.nume = text;
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
            dr.modPreparare = text;
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
                    id: dr.id,
                    nume: dr.nume,
                    modPreparare: dr.modPreparare,
                    categorie: dr.categorie);
                Recipes res1 = Recipes(
                    id: res[0].id,
                    idBautura: res[0].idBautura,
                    ingredient: res[0].ingredient,
                    cantitate: res[0].cantitate,
                    unitateDeMasura: res[0].unitateDeMasura);
                log(res1.unitateDeMasura);
                Recipes res2 = Recipes(
                    id: res[1].id,
                    idBautura: res[1].idBautura,
                    ingredient: res[1].ingredient,
                    cantitate: res[1].cantitate,
                    unitateDeMasura: res[1].unitateDeMasura);
                bool good = true;
                try {
                  await DBProvider.db.updateAll(drin, res1, res2);
                } catch (e) {
                  good = false;
                }
                if (good == true) widget.repo.updateAll(drin, res1, res2);
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
                String s = dr.nume + "+" + "m";
                Navigator.pop(context, s);
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
          await DBProvider.db.deleteAll(dr.id!, res[0].id!, res[1].id!);
        } catch (e) {
          good = false;
        }
        if (good == true) widget.repo.deleteAll(dr, res[0], res[1]);

        String s = dr.nume + "+" + "s";

        Navigator.pop(context, s);
        final snackBar = SnackBar(
          content: Builder(builder: (context) {
            return const Text('Bautura a fost stearsa');
          }),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
}
