import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ============================
  // USERS
  // ============================
  /// Guarda la información del usuario usando su UID real de Firebase
  Future<void> addUserInfo(Map<String, dynamic> userInfo, String uid) async {
    return _firestore.collection("users").doc(uid).set(userInfo);
  }

  /// Obtiene información de un usuario por UID
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserInfo(String uid) async {
    return _firestore.collection("users").doc(uid).get();
  }
  
  /// Actualiza el saldo de la billetera de un usuario específico
  Future<void> updateWalletBalance(String uid, int newBalance) async {
    return _firestore.collection("users").doc(uid).update({
      "walletBalance": newBalance,
    });
  }

  // ============================
  // PRODUCTS
  // ============================
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

  // ============================
  // ORDERS
  // ============================
  Future<DocumentReference<Map<String, dynamic>>> addOrder(
      Map<String, dynamic> orderInfo) {
    return _firestore.collection("orders").add(orderInfo);
  }

  Stream<QuerySnapshot> getOrders() {
    return _firestore.collection("orders").snapshots();
  }

  Future<void> deleteOrder(String id) {
    return _firestore.collection("orders").doc(id).delete();
  }
  
  /// Limpia todas las órdenes en Firestore usando un WriteBatch
  Future<void> clearAllOrders() async {
    CollectionReference ordersCollection = _firestore.collection('orders');

    QuerySnapshot snapshot = await ordersCollection.get();
    WriteBatch batch = _firestore.batch();

    for (var doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    return batch.commit();
  }
}