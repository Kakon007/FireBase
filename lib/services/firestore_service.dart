import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:g_in/model/product.dart';

class FireStoreService {
  Firestore _db = Firestore.instance;
  //method for passing product that we have created
  //this method is for add and update
  Future<void> saveProduct(Product product) {
    return _db
        .collection('product')
        .document(product.productId)
        .setData(product.toMap());
  }
  //Getter for All the Products

  Stream<List<Product>> getProducts() {
    return _db.collection('product').snapshots().map((snapshot) => snapshot
        .documents
        .map((document) => Product.fromFirestore(document.data))
        .toList());
  }

  Future removeProduct(String productId) {
    return _db.collection('products').document(productId).delete();
  }
}
