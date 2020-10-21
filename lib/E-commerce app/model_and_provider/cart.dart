import 'package:flutter/foundation.dart';

class Cart {
  final id;
  final name;
  final image;
  final qty;
  final price;

  Cart({
    this.id,
    this.name,
    this.image,
    this.qty,
    this.price,
  });
}

class CartData with ChangeNotifier {
  Map<int, Cart> _items = {};

  Map<int, Cart> get items {
    return {..._items};
  }

  void addItems(id, name, image, qty, price) {
    _items.putIfAbsent(
        id,
        () => Cart(
              id: id,
              name: name,
              image: image,
              qty: qty,
              price: price,
            ));
    notifyListeners();
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, carItem) {
      total += carItem.price * carItem.qty;
    });
    return total;
  }

  void removeItem(productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
