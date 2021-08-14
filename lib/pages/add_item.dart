import 'package:flutter/material.dart';
import 'package:shopping_list/shopping.dart';

class AddItem extends StatefulWidget {
  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  String? name = '';
  String? quantity = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Shopping Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 40, 40, 0),
        child: Form(
          key: _formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autofocus: true,
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(labelText: 'Item Name'),
                onSaved: (value) {
                  name = value;
                },
                validator: (String? value) {
                  return (value == null || value.isEmpty)
                      ? 'Item cannot be empty.'
                      : null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                onSaved: (value) {
                  quantity = (value == null || value.isEmpty) ? '1' : value;
                },
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: 'Quantity'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(context, {
                      "item": ShoppingItem(name: name!, quantity: quantity!),
                    });
                  }
                },
                icon: Icon(Icons.check),
                label: Text(
                  'Create New Item',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
