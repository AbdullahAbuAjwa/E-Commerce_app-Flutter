import 'package:flutter/material.dart';
import 'package:flutter_app2/E-commerce%20app/Widgets/badge.dart';
import 'package:flutter_app2/E-commerce%20app/Widgets/similar_prducts.dart';
import 'package:flutter_app2/E-commerce%20app/model_and_provider/cart.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';
import 'home_screen.dart';

class ProductDetailsScreen extends StatefulWidget {
  final id;
  final productName;
  final productOldPrice;

  final productNewPrice;
  final productPicture;
  final catName;
  final description;
  bool isFav = false;

  ProductDetailsScreen(this.id,
      this.productName,
      this.productOldPrice,
      this.productNewPrice,
      this.productPicture,
      this.catName,
      this.description,);

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Future<String> _asyncInputDialog(BuildContext context) async {
    String qty = '';
    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            title: Text('Enter the information'),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextField(
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter a QTY',
                    hintText: 'QTY',
                  ),
                  onChanged: (value) {
                    qty = value;
                  },
                ),
              ],
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      'Close',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text(
                      'Ok',
                      style: TextStyle(color: Colors.blue),
                    ),
                    onPressed: () {
                      final cart =
                      Provider.of<CartData>(context, listen: false);
                      if (qty == '') {
                        FlutterToast.showToast(
                          msg: 'Failed, please enter a qty',
                          toastLength: Toast.LENGTH_LONG,
                          backgroundColor: Colors.white12,
                        );
                      } else {
                        cart.addItems(
                          widget.id,
                          widget.productName.toString(),
                          widget.productPicture.toString(),
                          int.parse(qty),
                          widget.productNewPrice,
                        );
                        FlutterToast.showToast(
                          msg: 'Added successfully',
                          toastLength: Toast.LENGTH_SHORT,
                          backgroundColor: Colors.white12,
                        );
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

//  void getToast(String msg){
//
//  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartData>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('${widget.productName}'),
          actions: <Widget>[
            Consumer<CartData>(
              builder: (_, cartData, ch) =>
                  Badge(
                    child: ch,
                    value: cartData.itemCount.toString(),
                  ),
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return CartScreen();
                    },
                  ));
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) => HomeScreen(),
                ));
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 300,
                child: GridTile(
                  child: Container(
                    color: Colors.white,
                    child: Image.network('${widget.productPicture}'),
                  ),
                  footer: Container(
                    height: 50,
                    color: Colors.white70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          '${widget.productName}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '\$${widget.productNewPrice}',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.productOldPrice == null
                              ? ''
                              : '\$${widget.productOldPrice}',
                          style: TextStyle(
                            fontSize: 15,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              //    MaterialButtonView(),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: MaterialButton(
                        elevation: 0,
                        onPressed: () {
                          if (cart.items.containsKey(widget.id)) {
                            FlutterToast.showToast(
                              msg: 'This product already exist in a cart',
                              toastLength: Toast.LENGTH_LONG,
                              backgroundColor: Colors.white12,
                            );
                          } else {
                            _asyncInputDialog(context);
                          }
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: Text(
                          'Add to cart',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      widget.isFav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.isFav = !widget.isFav;
                        if (widget.isFav) {
//                          addFavorite(
//                            widget.id,
//                            widget.productName,
//                            widget.pr oductOldPrice,
//                            widget.productNewPrice.toString(),
//                            widget.catName,
//                            widget.description,
//                            widget.productPicture,
//                            widget.isFav,
//                          );
                        }
                      });
                    },
                  ),
                ],
              ),
              Divider(thickness: 1.8),
              DetailsWidget('${widget.description}'),
              Divider(thickness: 1.8),
              Container(
                  height: 250,
                  child: SimilarProducts(
                    widget.id,
                    widget.catName.toString(),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class MaterialButtonView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: MaterialButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Size'),
                        content: Text('Choose the size'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop(context);
                            },
                            child: Text(
                              'Close',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        ],
                      );
                    });
              },
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Size'),
                  Container(
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            )),
        Expanded(
            child: MaterialButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Color'),
                        content: Text('Choose the color'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop(context);
                            },
                            child: Text(
                              'Close',
                              style: TextStyle(color: Colors.red),
                            ),
                          )
                        ],
                      );
                    });
              },
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Color'),
                  Container(
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            )),
        Expanded(
            child: MaterialButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('QTY'),
                        content: Text('Choose the Qty'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop(context);
                            },
                            child: Text(
                              'Close',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    });
              },
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Qty'),
                  Container(
                    child: Icon(Icons.arrow_drop_down),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}

class DetailsWidget extends StatelessWidget {
  final description;

  DetailsWidget(this.description);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            'Product description',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
          ),
          subtitle: Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
