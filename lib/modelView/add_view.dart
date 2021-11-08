import 'dart:developer';

import 'package:drink_scout/database/data.dart';
import 'package:drink_scout/model/drinks.dart';
import 'package:drink_scout/model/recipes.dart';
import 'package:drink_scout/modelView/categories_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Define a custom Form widget.
class AddForm extends StatefulWidget {
  const AddForm({Key? key}) : super(key: key);

  @override
  AddFormState createState() {
    return AddFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class AddFormState extends State<AddForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final cat = TextEditingController();
  final ing = TextEditingController();
  final cant = TextEditingController();
  final unit = TextEditingController();
  final ing2 = TextEditingController();
  final cant2 = TextEditingController();
  final unit2 = TextEditingController();
  final mod = TextEditingController();

  @override
  Widget build(BuildContext context) {
    const title = "Add Recipes";
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
          _buildName(),
          const SizedBox(
            height: 30.0,
          ),
          _buildCategorie(),
          const SizedBox(
            height: 50.0,
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
            height: 30.0,
          ),
          _buildBtn()
        ]),
      ),
    );
  }

  Widget _buildName() {
    return Container(
      margin: EdgeInsets.all(20),
      width: 500,
      child: TextFormField(
        validator: (nume) {
          if (nume == null || nume.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        controller: name,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.coffee_maker_outlined),
          labelText: 'Nume',
        ),
      ),
    );
  }

  Widget _buildCategorie() {
    return Container(
      margin: EdgeInsets.all(20),
      width: 500,
      child: TextFormField(
        validator: (cat) {
          if (cat == null || cat.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
        controller: cat,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.add_chart),
          labelText: 'Categorie',
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
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                labelText: 'Ingredient',
                contentPadding: const EdgeInsets.all(20)),
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
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                labelText: 'Cantitate', contentPadding: EdgeInsets.all(20)),
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
            controller: unit,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                labelText: 'Unitate de masura',
                contentPadding: EdgeInsets.all(20)),
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
            controller: ing2,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                labelText: 'Ingredient',
                contentPadding: const EdgeInsets.all(20)),
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
            controller: cant2,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                labelText: 'Cantitate', contentPadding: EdgeInsets.all(20)),
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
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                labelText: 'Unitate de masura',
                contentPadding: EdgeInsets.all(20)),
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
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.no_drinks_rounded),
          labelText: 'Mod de preparare',
          contentPadding: EdgeInsets.symmetric(vertical: 120, horizontal: 20),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildBtn() {
    return Align(
      // padding: const EdgeInsets.symmetric(vertical: 16.0),
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () async {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            Drinks drink = Drinks(
                nume: name.text, modPreparare: mod.text, categorie: cat.text);
            Drinks dr = await DBProvider.db.addDrinks(drink);
            int id = dr.id!;
            Recipes res = Recipes(
                idBautura: id,
                ingredient: ing.text,
                cantitate: int.parse(cant.text),
                unitateDeMasura: unit.text);
            Recipes res2 = Recipes(
                idBautura: id,
                ingredient: ing2.text,
                cantitate: int.parse(cant2.text),
                unitateDeMasura: unit2.text);
            await DBProvider.db.addRecipes(res);
            await DBProvider.db.addRecipes(res2);

            Navigator.pop(context, dr);
            final snackBar = SnackBar(
              content: Builder(builder: (context) {
                return const Text('Adaugarea fost facuta');
              }),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        child: const Text('Adauga bautura'),
      ),
    );
  }
}
