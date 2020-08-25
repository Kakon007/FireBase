import 'package:flutter/cupertino.dart';
import 'package:g_in/model/product.dart';
import 'package:g_in/services/firestore_service.dart';
import 'package:uuid/uuid.dart';

class ProductProvider extends ChangeNotifier {
  final firestoreService = FireStoreService();
  String _name;
  double _price;
  String _productId;
  var uuid = Uuid();

  //Getter Function

  String get name => _name;
  double get price => _price;

  //Setter

  changeName(String value) {
    _name = value;
    notifyListeners();
  }

  changePrice(String value) {
    _price = double.parse(value);
    notifyListeners();
  }

  loadValue(Product product) {
    _name = product.name;
    _productId = product.productId;
    _price = product.price;
  }

  saveProduct() {
    //pass the value in product class
    final newProduct = Product(name: name, price: price, productId: uuid.v4());
    //pass the all value in firestore
    firestoreService.saveProduct(newProduct);
  }

  removeProduct(String productId) {
    firestoreService.removeProduct(productId);
  }
}
