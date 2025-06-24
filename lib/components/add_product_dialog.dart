import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/urls.dart';

class AddProductDialog extends StatefulWidget {
  final VoidCallback onProductAdded;

  const AddProductDialog({Key? key, required this.onProductAdded})
    : super(key: key);

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final _formKey = GlobalKey<FormState>();

  String? productName;
  String? productCode;
  String? imgUrl;
  String? qty;
  String? unitPrice;

  bool loading = false;

  void showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> addProduct(
    String productName,
    String img,
    int qty,
    int unitPrice,
  ) async {
    setState(() {
      loading = true;
    });

    try {
      final body = jsonEncode({
        "ProductName": productName,
        "ProductCode": DateTime.now().microsecondsSinceEpoch,
        "Img": img,
        "Qty": qty,
        "UnitPrice": unitPrice,
        "TotalPrice": qty * unitPrice,
      });

      final response = await http.post(
        Uri.parse(Urls.createProduct),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        widget.onProductAdded();

        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product added successfully')),
        );
      } else {
        showError('Failed to add product');
      }
    } catch (e) {
      showError('Error: $e');
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Product'),
      content: loading
          ? SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            )
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                      ),
                      validator: (val) => val == null || val.isEmpty
                          ? 'Enter product name'
                          : null,
                      onSaved: (val) => productName = val,
                    ),

                    TextFormField(
                      decoration: InputDecoration(labelText: 'Image URL'),
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Enter image URL' : null,
                      onSaved: (val) => imgUrl = val,
                    ),

                    TextFormField(
                      decoration: InputDecoration(labelText: 'Quantity'),
                      keyboardType: TextInputType.number,
                      validator: (val) =>
                          val == null || val.isEmpty ? 'Enter quantity' : null,
                      onSaved: (val) => qty = val,
                    ),

                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Unit Price',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (val) => val == null || val.isEmpty
                          ? 'Enter unit price'
                          : null,
                      onSaved: (val) => unitPrice = val,
                    ),


                  ],
                ),
              ),
            ),
      actions: [

        TextButton(
          onPressed: loading
              ? null
              : () {
                  Navigator.of(context).pop();
                },
          child: Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: loading
              ? null
              : () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    addProduct(
                      productName!,
                      imgUrl!,
                      int.parse(qty!),
                      int.parse(unitPrice!),
                    );
                  }
                },
          child: Text('Add'),
        ),
      ],
    );
  }
}
