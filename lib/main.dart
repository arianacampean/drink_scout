import 'dart:developer';

import 'package:drink_scout/database/data.dart';
import 'package:drink_scout/model/drinks.dart';
import 'package:drink_scout/model/recipes.dart';
import 'package:drink_scout/modelView/add_view.dart';
import 'package:drink_scout/modelView/categories_view.dart';
import 'package:flutter/material.dart';

void main() async {
  Drinks drink3 = Drinks(
      nume: "Suc de fructe",
      categorie: "Sucuri",
      modPreparare: "Amensteci toate ingredientele");

  //await DBProvider.db.addDrinks(drink3);

  Recipes res7 = Recipes(
      idBautura: 39,
      ingredient: "fructe",
      cantitate: 123,
      unitateDeMasura: " ");
  Recipes res8 = Recipes(
      idBautura: 39,
      ingredient: "gheata",
      cantitate: 3,
      unitateDeMasura: "cuburi");

  //await DBProvider.db.addRecipes(res7);
  // await DBProvider.db.addRecipes(res8);

  List<Drinks> lista = await DBProvider.db.getDrinks();
  List<Recipes> lis = await DBProvider.db.getRecipes();
  lista.forEach((element) {
    String s = element.id.toString() +
        " " +
        element.nume.toString() +
        " " +
        element.categorie.toString() +
        " " +
        element.modPreparare;
    log(s);
  });
  log("Retete:");
  lis.forEach((element) {
    String s = element.id.toString() +
        " " +
        element.idBautura.toString() +
        " " +
        element.ingredient.toString() +
        " " +
        element.cantitate.toString() +
        " " +
        element.unitateDeMasura;
    log(s);
  });
  var items2_map = await DBProvider.db.getCategoriesMap();
  items2_map.forEach((key, value) => {log(key + value.toString())});
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //List cat = DBProvider.db.getCategories() as List;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Categories(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
