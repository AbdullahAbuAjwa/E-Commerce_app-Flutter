import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> addFavorite(
  id,
  name,
  oldPrice,
  price,
  catName,
  description,
  image,
  isFav,
) async {
  var firebaseUser = await FirebaseAuth.instance.currentUser();

  final firestoreInstance = Firestore.instance;

  firestoreInstance
      .collection('Favorites')
      .add({
    'id': id,
    'name': name,
    'old_price': oldPrice,
    'price': oldPrice,
    'cat_name': catName,
    'cat_name': catName,
    'description': description,
    'image': image,
    'isFav': isFav,
  });
//  _orders.insert(
//      0,
//      OrderItem(
//          id: firebaseUser.uid,
//          amount: total,
//          dateTime: Timestamp.now(),
//          products: cartProducts));
//  notifyListeners();
}
