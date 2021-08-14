import 'package:flutter/material.dart';
import 'package:shopping_list/shopping.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ShoppingListPage extends StatefulWidget {
  @override
  _ShoppingListPageState createState() => _ShoppingListPageState();
}

class _ShoppingListPageState extends State<ShoppingListPage> {
  List<ShoppingItem> shoppingList = [
    // ShoppingItem(name: "Eggs", quantity: "10 dozens"),
    // ShoppingItem(name: "Cheese", quantity: "200g"),
    // ShoppingItem(name: "Milk", quantity: "2 cartons"),
    // ShoppingItem(name: "Steak", quantity: "1"),
  ];
  var deleteMode = false;

  @override
  void initState() {
    super.initState();
    _loadList();
  }

// Load shoppingList from Shared Preferences (or initialise to empty)
  void _loadList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      shoppingList = (prefs.getStringList('shoppingList') ?? [])
          .map((item) => ShoppingItem.fromJson(jsonDecode(item)))
          .toList();
    });
  }

// Save current shoppingList to Shared Preferences (or empty the list, if clear set to true)
  void _saveList() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'shoppingList',
        shoppingList.map((item) {
          return jsonEncode(item).toString();
        }).toList());
    if (shoppingList.length == 0) {
      setState(() {
        deleteMode = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: (shoppingList.length == 0)
            ? null
            : [
                // VerticalDivider(
                //   color: Colors.grey[800],
                //   thickness: 1,
                //   indent: 10,
                //   endIndent: 10,
                // ),
                // IconButton(
                //     onPressed: () {
                //       setState(() {
                //         deleteMode = !deleteMode;
                //       });
                //     },
                //     icon: Icon(
                //         deleteMode ? Icons.check_box_outlined : Icons.delete)),
                TextButton(
                  onPressed: () {
                    setState(() {
                      deleteMode = !deleteMode;
                    });
                  },
                  child: Text(
                    deleteMode ? 'Finish' : 'Edit',
                    style: TextStyle(
                      color: Colors.grey[100],
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
        title: Text("Shopping List App"),
      ),
      // FloatingActionButton navigates to add_item page for entering new shopping item
      floatingActionButton: deleteMode
          ? FloatingActionButton.extended(
              heroTag: 'empty_list',
              label: Text('Empty List'),
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  // deleteMode = false;
                  shoppingList = [];
                });
                _saveList();
              },
            )
          : FloatingActionButton.extended(
              heroTag: 'add_item',
              label: Text('Add Item'),
              icon: Icon(Icons.add),
              onPressed: () async {
                dynamic result =
                    await Navigator.pushNamed(context, '/add_item');
                setState(() {
                  // deleteMode = false;
                  if (result != null) {
                    shoppingList.add(result['item']);
                    _saveList();
                  }
                  print(shoppingList);
                });
              },
            ),
      // ListView builds the list of shopping wrapped in ShoppingCard widgets
      body: ListView.builder(
        itemCount: shoppingList.length,
        itemBuilder: (context, index) {
          return ShoppingCard(
            shoppingItem: shoppingList[index],
            deleteMode: deleteMode,
            saveList: _saveList,
            deleteItem: () {
              setState(
                () {
                  shoppingList.remove(shoppingList[index]);
                },
              );
            },
          );
        },
      ),
    );
  }
}
