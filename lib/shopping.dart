import 'package:flutter/material.dart';

// Takes in name and quantity as attributes
class ShoppingItem {
  String name; // Cannot be null
  String quantity; // Default is '1'
  bool isChecked; // Initially not checked from shoppingList
  ShoppingItem(
      {required this.name, required this.quantity, this.isChecked = false});

  @override
  String toString() {
    return 'ShoppingItem(name: ${this.name}, quantity: ${this.quantity}, isChecked: ${this.isChecked})';
  }

  // Named constructor
  ShoppingItem.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        quantity = json['quantity'],
        isChecked = json['isChecked'];

  Map<String, dynamic> toJson() {
    return {'name': name, 'quantity': quantity, 'isChecked': isChecked};
  }
}

// Takes in a ShoppingItem and returns a Card widget
class ShoppingCard extends StatefulWidget {
  final ShoppingItem shoppingItem;
  // delete item from shoppingList
  final Function deleteItem;
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
