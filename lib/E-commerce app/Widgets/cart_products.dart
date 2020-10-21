import 'package:flutter/material.dart';
import 'package:flutter_app2/E-commerce%20app/model_and_provider/cart.dart';
import 'package:provider/provider.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var productCart = [];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartData>(context, listen: false);
    return ListView.builder(
        itemCount: cart.itemCount,
        itemBuilder: (BuildContext context, int index) {
          return SingleCartProduct(
            cart.items.values.toList()[index].id,
            cart.items.values.toList()[index].name.toString(),
            cart.items.values.toList()[index].image,
            cart.items.values.toList()[index].price,
            cart.items.values.toList()[index].qty,
          );
        });
  }
}

class SingleCartProduct extends StatelessWidget {
  final int prodId;
  final prodName;
  final prodPicture;
  final prodPrice;
  final prodQty;

  const SingleCartProduct(this.prodId, this.prodName, this.prodPicture,
      this.prodPrice, this.prodQty);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(prodId),
      direction: DismissDirection.horizontal,
      background: Container(
        child: Icon(
          Icons.delete,
          color: Colors.black,
          size: 35,
        ),
        color: Colors.red,
      ),
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Are you sure ?'),
            content: Text('Do you want to remove this item.'),
            actions: <Widget>[
              FlatButton(
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  }),
              FlatButton(
                  child: Text(
                    'Yes',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  }),
            ],
          ),
        );
      },
      onDismissed: (item) {
        Provider.of<CartData>(context, listen: false).removeItem(prodId);
      },
      child: Card(
        margin: EdgeInsets.only(top: 8, left: 8, right: 8),
        elevation: 6,
        color: Color(0xFFFFFFFF),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.elliptical(15, 15),
          ),
        ),
        child: ListTile(
          title: Container(
            margin: EdgeInsets.only(top: 8),
            child: Text(
              prodName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('Price: ', style: TextStyle(fontSize: 16)),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            '\$$prodPrice',
                            style: TextStyle(color: Colors.red),
                          )),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('Quantity: ', style: TextStyle(fontSize: 16)),
                      Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            '$prodQty',
                            style: TextStyle(color: Colors.red),
                          )),
                    ],
                  ),
                ],
              ),
            ],
          ),
          leading: Image.network(
            prodPicture,
          ),
        ),
      ),
    );
  }
}
