import 'package:flutter/material.dart';
import 'package:shopping_list/pages/add_item.dart';
import 'package:shopping_list/pages/shopping_list.dart';

void main() {
  runApp(MaterialApp(
    // home: ShoppingList(),
    initialRoute: '/',
    routes: {
      '/': (context) => ShoppingListPage(), // Page with list of shopping
      '/add_item': (context) => AddItem(), // Page for adding shopping item
    },
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
        // titleTextStyle: TextStyle(
        //   color: Colors.black,
        // ),
        // toolbarTextStyle: TextStyle(
        //   color: Colors.amber,
        // ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
        ),
      ),
      textTheme: TextTheme(
        button: TextStyle(fontSize: 16),
        bodyText2: TextStyle(
          fontSize: 20,
        ),
        subtitle1: TextStyle(
          fontSize: 20,
        ),
      ),
      scaffoldBackgroundColor: Colors.grey[300],
      cardColor: Colors.grey[100],
      primaryColor: Colors.deepPurple,
      accentColor: Colors.deepPurple,
    ),
  ));
}
