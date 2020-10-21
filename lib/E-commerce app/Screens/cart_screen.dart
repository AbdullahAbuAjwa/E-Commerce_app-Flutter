import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/E-commerce%20app/Widgets/cart_products.dart';
import 'package:flutter_app2/E-commerce%20app/Widgets/drawer.dart';
import 'package:flutter_app2/E-commerce%20app/model_and_provider/cart.dart';
import 'package:flutter_app2/E-commerce%20app/model_and_provider/order.dart';

import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartData>(context);

    return Scaffold(
      drawer: ShopDrawer(),
      appBar: AppBar(
        elevation: 0,
        title: Text('Cart'),
      ),
      body: cart.itemCount == 0
          ? Center(
              child: Text(
              'No Item in the cart',
              style: TextStyle(fontSize: 20),
            ))
          : CartProducts(),
      bottomNavigationBar: (cart.itemCount == 0)
          ? null
          : Container(
              color: Colors.black26,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Total: ',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        '\$${cart.totalAmount.toStringAsFixed(2).toString()}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        margin: EdgeInsets.only(right: 8),
                        child: OrderButton(cart: cart)),
                  ),
                ],
              ),
            ),
    );
  }
}

class OrderButton extends StatefulWidget {
  final CartData cart;

  const OrderButton({Key key, @required this.cart}) : super(key: key);

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  final firestoreInstance = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading
          ? CircularProgressIndicator()
          : Text(
              'Make order',
              style: TextStyle(
                  fontSize: 18, color: Colors.red, fontWeight: FontWeight.bold),
            ),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.items.values.toList(), widget.cart.totalAmount);
              setState(() {
                _isLoading = false;
              });
              _showMyDialog();
              widget.cart.clear();
            },
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(
            'Your order has been processed, within minutes we will deliver it.\n Enjoy!!',
            style: TextStyle(color: Colors.blue),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                'OK',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
