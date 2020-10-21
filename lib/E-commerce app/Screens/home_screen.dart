import 'package:flutter/material.dart';
import 'package:flutter_app2/E-commerce%20app/Widgets/badge.dart';
import 'package:flutter_app2/E-commerce%20app/Widgets/carousel_pro.dart';
import 'package:flutter_app2/E-commerce%20app/Widgets/categories_list.dart';
import 'package:flutter_app2/E-commerce%20app/Widgets/drawer.dart';
import 'package:flutter_app2/E-commerce%20app/Widgets/recent_products.dart';
import 'package:flutter_app2/E-commerce%20app/model_and_provider/cart.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartData>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Shop App'),
        actions: <Widget>[
          Consumer<CartData>(
            builder: (_, cartData, ch) => Badge(
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
        ],
      ),
      drawer: ShopDrawer(),
      body: Column(
        children: <Widget>[
          CarouselPro(),
          CategoriesList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recent products',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
          ),
          Flexible(child: RecentProducts()),
        ],
      ),
    );
  }
}
