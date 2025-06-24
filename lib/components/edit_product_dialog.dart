import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../utils/urls.dart';


class EditProductDialog extends StatefulWidget {
  final Data product;
  final Function onUpdated;

  const EditProductDialog({
    Key? key,
    required this.product,
    required this.onUpdated,
  }) : super(key: key);

  @override
  State<EditProductDialog> createState() => _EditProductDialogState();
}

class _EditProductDialogState extends State<EditProductDialog> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController imgController;
  late TextEditingController qtyController;
  late TextEditingController priceController;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.productName);
    imgController = TextEditingController(text: widget.product.img);
    qtyController = TextEditingController(text: widget.product.qty.toString());
    priceController = TextEditingController(text: widget.product.unitPrice.toString());
  }

  Future<void> updateProduct() async {


    try {
      final body = jsonEncode({
        "ProductName": nameController.text,
        "Img": imgController.text,
        "Qty": int.parse(qtyController.text),
        "UnitPrice": int.parse(priceController.text),
        "TotalPrice": int.parse(qtyController.text) * int.parse(priceController.text),
      });

      final url = Urls.updateProduct(widget.product.sId!);


      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: body,
      );


      if (response.statusCode == 200 || response.statusCode == 201)
      {
        widget.onUpdated(); // callback
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product updated')),
        );
        setState(() {
          loading = true;
        });

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update failed: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Update Product'),
      content: loading
          ? Center(child: CircularProgressIndicator())
          : Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),

              TextFormField(
                controller: imgController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),

              TextFormField(
                controller: qtyController,
                decoration: InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),

              TextFormField(
                controller: priceController,
                decoration: InputDecoration(labelText: 'Unit Price'),
                keyboardType: TextInputType.number,
                validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),

            ],
          ),
        ),
      ),
      actions: [

        TextButton(
          onPressed: loading ? null : () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),

        ElevatedButton(
          onPressed: loading
              ? null
              : () {
            if (_formKey.currentState!.validate()) {
              updateProduct();
            }
          },
          child: Text('Update'),
        ),
      ],
    );
  }
}
