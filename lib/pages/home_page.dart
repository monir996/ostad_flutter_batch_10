import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../components/edit_product_dialog.dart';
import '../models/product_model.dart';
import '../utils/urls.dart';
import '../components/add_product_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Data> productList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  //--------------------- Fetch Products from API ---------------------
  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(Urls.readProduct));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final products = productModel.fromJson(jsonData);
        setState(() {
          productList = products.data ?? [];
        });
      } else {
        showMsg('Failed to load products');
      }
    } catch (e) {
      showMsg('Error: $e');
    }

    setState(() {
      isLoading = false;
    });
  }

  // --------------------- Delete Product -----------------
  Future<void> deleteProduct(String id) async {

    try {
      final response = await http.get(Uri.parse(Urls.deleteProduct(id)),
      headers: {'Content-Type': 'application/json',}
      );

      if (response.statusCode == 200 || response.statusCode == 201) {

        // Refresh the UI after successfully deleted
        await fetchProducts();
        showMsg('Product deleted successfully');

        setState(() {
          isLoading = true;
        });
      } else {
        showMsg('Failed to delete product');
      }
    } catch (e) {
      showMsg('Error: $e');
    }

    setState(() {
      isLoading = false;
    });
  }


  // -------------- SnackBar ----------------
  void showMsg(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            onPressed: fetchProducts,
            icon: Icon(Icons.refresh),
            tooltip: "Refresh",
          ),
        ],
      ),

      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : productList.isEmpty
            ? Center(child: Text('No Products found'))
            : Padding(
                padding: EdgeInsets.all(8.0),

                child: GridView.builder(

                  itemCount: productList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,

                  ),

                  itemBuilder: (context, index) {
                    final product = productList[index];

                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Padding(
                        padding: EdgeInsets.all(8.0),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,

                          children: [
                            Expanded(
                              child:
                                  product.img != null && product.img!.isNotEmpty
                                  ? Image.network(
                                      product.img!,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      color: Colors.grey[300],
                                      child: Icon(Icons.image, size: 50),
                                    ),
                            ),

                            SizedBox(height: 6),

                            Text(
                              product.productName ?? "No Name",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(height: 4),

                            Text(
                              "Price: ৳${product.unitPrice ?? 0}\nQty: ${product.qty ?? 0}",
                            ),

                            SizedBox(height: 6),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                ElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) => EditProductDialog(
                                          product: product,
                                          onUpdated: ()=> fetchProducts(),
                                        )
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                  ),
                                  child: Text('Update', style: TextStyle(color: Colors.white),),
                                ),

                                ElevatedButton(
                                  onPressed: () {
                                    if (product.sId != null) {
                                      deleteProduct(product.sId!);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red,
                                  ),
                                  child: Text('Delete', style: TextStyle(color: Colors.white),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {

          showDialog(
              context: context,
              builder: (_)=> AddProductDialog(
                  onProductAdded: fetchProducts
              )
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
