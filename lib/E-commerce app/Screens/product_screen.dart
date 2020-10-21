import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:flutter_app2/E-commerce%20app/Widgets/single_product.dart';

class ProductScreen extends StatefulWidget {
  final categoryName;

  ProductScreen(this.categoryName);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String name;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.categoryName}'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.all(Radius.circular(30.0)),
              child: TextField(
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
                    suffixIcon: Material(
                      elevation: 2.5,
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      child: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    border: InputBorder.none,
                    hintText: "Search"),
                onChanged: (value) {
                  initiateSearch(value);
                },
              ),
            ),
          ),
          Flexible(
            child: StreamBuilder(
              stream: name != null && name.trim() != ''
                  ? Firestore.instance
                      .collection('Products')
                      .orderBy('id')
                      .where('cat_name',
                          isEqualTo: widget.categoryName.toString())
                      .where('name', isEqualTo: name)
                      .snapshots()
                  : Firestore.instance
                      .collection('Products')
                      .orderBy('id')
                      .where('cat_name',
                          isEqualTo: widget.categoryName.toString())
                      .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var chatDocs = snapshot.data.documents;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: chatDocs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(4),
                      child: SingleProduct(
                        chatDocs[index]['id'],
                        chatDocs[index]['name'],
                        chatDocs[index]['image'],
                        chatDocs[index]['old_price'],
                        chatDocs[index]['price'],
                        chatDocs[index]['cat_name'],
                        chatDocs[index]['description'],
                        key: ValueKey(chatDocs[index].documentID),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void initiateSearch(String val) {
    setState(() {
      name = val.trim();
    });
  }
}
