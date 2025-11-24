import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addUserInfo(
      Map<String, dynamic> userInfo, String id) async {
    return _firestore.collection("users").doc(id).set(userInfo);
  }

  Future<DocumentReference<Map<String, dynamic>>> addProduct(
      Map<String, dynamic> productInfo) {
    return _firestore.collection("products").add(productInfo);
  }

  Stream<QuerySnapshot> getProducts(String category) {
    return _firestore
        .collection("products")
        .where("category", isEqualTo: category)
        .snapshots();
  }
}
