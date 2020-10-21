import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'cart.dart';

class OrderItem {
  final id;
  final amount;
  final List<Cart> products;
  final Timestamp dateTime;

  OrderItem({this.id, this.amount, this.products, this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchOrdersData() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();

    final List<OrderItem> loadedOrders = [];
    final extractedData = Firestore.instance
        .collection('users')
        .document(user.uid)
        .collection('Orders') as Map<String, dynamic>;

    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedOrders.add(
        OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: (orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map(
                (item) => Cart(
                  id: item['id'],
                  price: item['price'],
                  qty: item['quantity'],
                  name: item['name'],
                ),
              )
              .toList(),
        ),
      );
    });
    _orders = loadedOrders.toList();
    notifyListeners();
  }

  Future<void> addOrder(List<Cart> cartProducts, double total) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser();

    final firestoreInstance = Firestore.instance;

    firestoreInstance
        .collection('users')
        .document(firebaseUser.uid)
        .collection('Orders')
        .add({
      'amount': total,
      'dateTime': Timestamp.now(),
      'products': cartProducts
          .map((cp) => {
                'id': cp.id,
                'name': cp.name,
                'quantity': cp.qty,
                'price': cp.price,
              })
          .toList()
    });
    _orders.insert(
        0,
        OrderItem(
            id: firebaseUser.uid,
            amount: total,
            dateTime: Timestamp.now(),
            products: cartProducts));
    notifyListeners();
  }
}
