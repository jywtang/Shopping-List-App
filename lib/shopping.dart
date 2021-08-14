import 'package:flutter/material.dart';

/// Defines a shopping item
class ShoppingItem {
  /// Name of the item, cannot be null
  String name;

  /// The quantity of item, the default is 1
  String quantity;

  /// Whether something is checked off from shoppinglist, default false
  bool isChecked;
  ShoppingItem(
      {required this.name, required this.quantity, this.isChecked = false});

  // @override
  // String toString() {
  //   return 'ShoppingItem(name: ${this.name}, quantity: ${this.quantity}, isChecked: ${this.isChecked})';
  // }

  /// A named constructor that takes a json object
  ShoppingItem.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        quantity = json['quantity'],
        isChecked = json['isChecked'];

  Map<String, dynamic> toJson() {
    return {'name': name, 'quantity': quantity, 'isChecked': isChecked};
  }
}

/// Defines a card in the ShoppingListPage
///
/// Takes in a [ShoppingItem] and returns a [Card] for the item
class ShoppingCard extends StatefulWidget {
  final ShoppingItem shoppingItem;
  // Delete item from shoppingList
  final Function deleteItem;
  // Save current Shopping List
  final Function saveList;
  final bool deleteMode;

  ShoppingCard(
      {required this.shoppingItem,
      required this.deleteItem,
      required this.saveList,
      required this.deleteMode});

  @override
  _ShoppingCardState createState() => _ShoppingCardState();
}

class _ShoppingCardState extends State<ShoppingCard> {
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(
      decoration:
          widget.shoppingItem.isChecked ? TextDecoration.lineThrough : null,
      decorationThickness: 2.0,
    );

    return Card(
      margin: EdgeInsets.fromLTRB(5, 5, 0, 0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 5, 10),
        child: Row(
          children: [
            // Name of item
            Expanded(
              flex: 2,
              child: Text(
                widget.shoppingItem.name,
                style: textStyle,
              ),
            ),
            // Quantity of item
            Expanded(
              flex: 1,
              child: Text(
                widget.shoppingItem.quantity,
                style: textStyle,
              ),
            ),
            // Shows a delete button or a checkbox, depending on
            // whether deleteMode is activated or not
            widget.deleteMode
                ? IconButton(
                    onPressed: () {
                      widget.deleteItem();
                      widget.saveList();
                    },
                    icon: Icon(Icons.delete))
                : Checkbox(
                    value: widget.shoppingItem.isChecked,
                    onChanged: (bool? value) {
                      setState(
                        () {
                          widget.shoppingItem.isChecked = value!;
                        },
                      );
                      widget.saveList();
                    },
                  )
          ],
        ),
      ),
    );
  }
}
