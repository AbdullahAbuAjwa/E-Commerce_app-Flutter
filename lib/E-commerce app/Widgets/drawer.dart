import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/E-commerce%20app/Screens/cart_screen.dart';
import 'package:flutter_app2/E-commerce%20app/Screens/home_screen.dart';
import 'package:flutter_app2/E-commerce%20app/Screens/login.dart';
import 'package:flutter_app2/E-commerce%20app/Screens/order_screen.dart';
import 'package:flutter_app2/E-commerce%20app/Screens/profile_screen.dart';
import 'package:flutter_app2/E-commerce%20app/model_and_provider/get_user_data.dart';

class ShopDrawer extends StatefulWidget {
  @override
  _ShopDrawerState createState() => _ShopDrawerState();
}

class _ShopDrawerState extends State<ShopDrawer> {
  @override
  void initState() {
    setState(() {
      getUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text(data == null ? 'email' : data['email']),
            accountName: Text(data == null ? 'name' : data['username']),
            currentAccountPicture: Container(
              height: 40.0,
              width: 40.0,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(60.0),
                image: data == null
                    ? DecorationImage(
                        image: AssetImage(
                          'assets/images/person.png',
                        ),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: NetworkImage(
                          data['image_url'],
                        ),
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          InkWell(
            child: ListTile(
              dense: false,
              title: Text('Home Page'),
              leading: Icon(
                Icons.home,
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return HomeScreen();
                  },
                ),
              );
            },
          ),
          InkWell(
            child: ListTile(
              title: Text('My Account'),
              leading: Icon(
                Icons.person,
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProfileScreen();
                  },
                ),
              );
            },
          ),
          InkWell(
            child: ListTile(
              title: Text('My Orders'),
              leading: Icon(
                Icons.shopping_basket,
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                return OrderScreen();
              }));
            },
          ),
          InkWell(
            child: ListTile(
              title: Text('Shopping cart'),
              leading: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                return CartScreen();
              }));
            },
          ),
          InkWell(
            child: ListTile(
              title: Text('Favorites'),
              leading: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
            ),
          ),
          Divider(),
          InkWell(
            child: ListTile(
              title: Text('Settings'),
              leading: Icon(
                Icons.settings,
                color: Colors.blue,
              ),
            ),
          ),
          InkWell(
            child: ListTile(
              title: Text('About'),
              leading: Icon(Icons.help, color: Colors.blue),
            ),
          ),
          Divider(),
          InkWell(
            onTap: () {
              _signOut();
//              FirebaseAuth.instance.signOut().then((value) {
//                Navigator.pushReplacement(context,
//                    MaterialPageRoute(builder: (context) => LoginScreen()));
//              });
            },
            child: ListTile(
              title: Text('Log out'),
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signOut() {
    FirebaseAuth.instance.signOut().then((onValue) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }
}
