import 'package:flutter/material.dart';
import 'package:g_in/model/product.dart';
import 'package:g_in/provider/product_provider.dart';
import 'package:g_in/screen/product.dart';
import 'package:provider/provider.dart';

class EditProducts extends StatefulWidget {
  final Product products;
  EditProducts([this.products]);

  @override
  _EditProductsState createState() => _EditProductsState();
}

class _EditProductsState extends State<EditProducts> {
  final nameController = TextEditingController();
  final priceController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.products == null) {
      nameController.text = '';
      priceController.text = '';
    } else {
      //controllers update
      nameController.text = widget.products.name;
      priceController.text = widget.products.price.toString();
      //State update
      new Future.delayed(Duration.zero, () {
        final productProvider =
            Provider.of<ProductProvider>(context, listen: false);
        productProvider.loadValue(widget.products);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Product',
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.arrow_back,
        //       size: 30,
        //     ),
        //     onPressed: () {
        //       Navigator.of(context).pushReplacementNamed('product');
        //     },
        //   )
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Product Nmae',
              ),
              onChanged: (value) {
                productProvider.changeName(value);
              },
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Product Price',
              ),
              onChanged: (value) {
                productProvider.changePrice(value);
              },
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                productProvider.saveProduct();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
              color: Colors.green,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                productProvider.removeProduct(widget.products.productId);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
              color: Colors.red,
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
